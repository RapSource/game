import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const gameInfo = 'GAME_INFO';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isGameInfoActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(gameInfo) ?? false;
  }

  void setGameInfo(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(gameInfo, value);
  }
}