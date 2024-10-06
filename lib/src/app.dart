import 'package:fast_location/src/modules/history/page/history_page.dart';
import 'package:fast_location/src/modules/home/page/home_page.dart';
import 'package:fast_location/src/modules/initial/page/initial_page.dart';
import 'package:fast_location/src/routes/app_router.dart';
import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:fast_location/src/shared/colors/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'Fast Location',
            // Tema claro
            theme: ThemeData(
              useMaterial3: false,
              colorScheme: themeModel.colorScheme,
            ),
            // Tema escuro
            darkTheme: ThemeData(
              useMaterial3: false,
              colorScheme:
                  themeModel.colorScheme.copyWith(brightness: Brightness.dark),
            ),
            themeMode: themeModel.currentTheme,
            home: const InitialPage(),
            debugShowCheckedModeBanner: false,
            routes: {
              AppRouter.home: (_) => const HomePage(),
              AppRouter.history: (_) => const HistoryPage(),
            },
          );
        },
      ),
    );
  }
}
