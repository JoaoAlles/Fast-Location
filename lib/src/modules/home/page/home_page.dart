import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/src/modules/home/components/address_list.dart';
import 'package:fast_location/src/modules/home/components/search_address.dart';
import 'package:fast_location/src/modules/home/components/search_empty.dart';
import 'package:fast_location/src/modules/home/controller/home_controller.dart';
import 'package:fast_location/src/routes/app_router.dart';
import 'package:fast_location/src/shared/components/app_button.dart';
import 'package:fast_location/src/shared/components/app_loading.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import '../../../shared/colors/app_colors.dart';
import '../../../shared/colors/change_theme.dart';
import '../../../shared/metrics/app_metrics.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();
  TextEditingController searchController = TextEditingController();
  late ReactionDisposer errorReactionDiposer;
  late ReactionDisposer errorRouteReactionDiposer;

  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reactsToError();
    reactsToRouteError();
  }

  @override
  void dispose() {
    searchController.dispose();
    errorReactionDiposer();
    errorRouteReactionDiposer();
    super.dispose();
  }

  void reactsToError() {
    errorReactionDiposer = reaction((_) => _controller.hasError, (
      bool error,
    ) {
      if (error) openDialog("Endereço não localizado");
      _controller.hasError = false;
    });
  }

  void reactsToRouteError() {
    errorRouteReactionDiposer = reaction((_) => _controller.hasRouteError, (
      bool routeError,
    ) {
      if (routeError) {
        openDialog(
          "Busque um endereço para traçar sua rota",
          height: 120,
        );
      }
      _controller.hasRouteError = false;
    });
  }

  void openDialog(String message, {double? height}) {
    showDialog(
      // Abre um diálogo de alerta.
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: height ?? 100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                AppButton(
                  label: "Fechar",
                  action: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(18.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _mainColor = _tempMainColor;
                  _shadeColor = _tempShadeColor;
                  debugPrint(_mainColor.toString());
                  Provider.of<ThemeModel>(context, listen: false).colorScheme =
                      ColorScheme.fromSeed(
                    seedColor: _mainColor!,
                  );
                });
              },
              child: const Text('SUBMIT'),
            ),
          ],
        );
      },
    );
  }

  void _openFullMaterialColorPicker() async {
    _openDialog(
      "Full Material Color picker",
      MaterialColorPicker(
        colors: fullMaterialColors,
        selectedColor: _mainColor,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _controller.isLoading
          ? const AppLoading()
          : Scaffold(
              backgroundColor: Theme.of(context).colorScheme.background,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.swap_horiz,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Fast Location",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: _controller.hasAddress
                                  ? SearchAddress(
                                      address: _controller.lastAddress!,
                                    )
                                  : const SearchEmpty(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                            label: "Localizar endereço",
                            action: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: SizedBox(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: searchController,
                                            textAlign: TextAlign.start,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: "Digite o CEP",
                                            ),
                                          ),
                                          AppButton(
                                            label: "Buscar",
                                            action: () {
                                              _controller.getAddress(
                                                searchController.text,
                                              );
                                              Navigator.of(context).pop();
                                              searchController.clear();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.place,
                                  color: Theme.of(context).colorScheme.primary),
                              SizedBox(width: 5),
                              Text(
                                "Últimos endereços localizados",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          AddressList(
                            addressList: _controller.addressRecentList,
                          ),
                          const SizedBox(height: 20),
                          AppButton(
                            label: "Histórico de endereços",
                            action: () {
                              Navigator.of(context)
                                  .pushNamed(AppRouter.history);
                            },
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                child: Container(
                  height: AppMetrics.barHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<ThemeModel>(context, listen: false)
                              .setLightTheme();
                        },
                        icon: Icon(Icons.light_mode),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<ThemeModel>(context, listen: false)
                              .setDarkTheme();
                        },
                        icon: Icon(Icons.dark_mode),
                      ),
                      IconButton(
                        onPressed: _openFullMaterialColorPicker,
                        icon: Icon(Icons.color_lens),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () => _controller.route(context),
                tooltip: 'Traçar rota',
                child: const Icon(
                  Icons.fork_right,
                  size: 45,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
            );
    });
  }
}
