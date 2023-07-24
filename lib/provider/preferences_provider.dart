import 'package:flutter/material.dart';

import '../common/style.dart';
import '../model/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper});

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isGameInfoActive = false;
  bool get isGameInfoActive => _isGameInfoActive;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }

  void _getGameInfoPreferences() async {
    _isGameInfoActive = await preferencesHelper.isGameInfoActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }

  void enableGameInfo(bool value) {
    preferencesHelper.setGameInfo(value);
    _getGameInfoPreferences();
  }
}