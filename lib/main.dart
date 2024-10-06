import 'package:fast_location/src/app.dart';
import 'package:fast_location/src/shared/colors/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:fast_location/src/shared/storage/hive_configuration.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  HiveConfiguration.initHiveDatabase().then((_) {
    const myApp = MyApp();
    runApp(
      ChangeNotifierProvider(
        create: (context) => ThemeModel(),
        child: myApp,
      ),
    );
  });
}
