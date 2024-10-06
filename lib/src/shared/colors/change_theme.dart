import 'package:fast_location/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart'; // Importa o framework Flutter para desenvolvimento de interface.

/*// Define a classe ThemeModel que gerencia o tema do aplicativo.
class ThemeModel extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light; // Define o tema atual como claro por padrão.
  // Adiciona a propriedade colorScheme

  // Getter para obter o tema atual.
  ThemeMode get currentTheme => _currentTheme;

  // Alterna o tema entre claro e escuro.
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como claro.
  void setLightTheme() {
    _currentTheme = ThemeMode.light;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como escuro.
  void setDarkTheme() {
    _currentTheme = ThemeMode.dark;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }
}*/

// Define a classe ThemeModel que gerencia o tema do aplicativo.
class ThemeModel extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light; // Define o tema atual como claro por padrão.
  ColorScheme _colorScheme = ColorScheme.fromSeed(seedColor: AppColors.appThemeColor, brightness: Brightness.light);

  // Getter para obter o tema atual.
  ThemeMode get currentTheme => _currentTheme;

  // Getter para obter o esquema de cores atual.
  ColorScheme get colorScheme => _colorScheme;

  // Setter para definir o esquema de cores atual.
  set colorScheme(ColorScheme newColorScheme) {
    _colorScheme = newColorScheme;
    notifyListeners();
  }

  // Alterna o tema entre claro e escuro.
  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como claro.
  void setLightTheme() {
    _currentTheme = ThemeMode.light;
    _colorScheme = ColorScheme.fromSeed(seedColor: _colorScheme.primary, brightness: Brightness.light);
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }

  // Define o tema como escuro.
  void setDarkTheme() {
    _currentTheme = ThemeMode.dark;
    _colorScheme = ColorScheme.fromSeed(seedColor: _colorScheme.primary, brightness: Brightness.dark);
    notifyListeners(); // Notifica os ouvintes sobre a mudança no tema.
  }
}
