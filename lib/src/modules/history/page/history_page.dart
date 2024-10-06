import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fast_location/src/modules/history/controller/history_controller.dart';
import 'package:fast_location/src/modules/home/components/address_list.dart';
import 'package:fast_location/src/shared/components/app_loading.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final HistoryController _controller = HistoryController();
  @override
  void initState() {
    super.initState();
    _controller.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _controller.isLoading
          ? const AppLoading()
          : Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share_location,
                                size: 30,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Endereços Localizados",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          AddressList(
                            addressList: _controller.addressHistoryList,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
