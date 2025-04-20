import 'package:flutter/material.dart';
import 'package:ploop_fe/theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ColorTheme _theme = GreenTheme();

  ColorTheme get theme => _theme;

  void setTheme(ColorTheme newTheme) {
    _theme = newTheme;
    notifyListeners();
  }
}
