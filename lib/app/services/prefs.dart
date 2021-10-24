import 'package:first_ally_demo/app/data/providers/shared_preferences.dart';

class Prefs {

  static Future<bool> get authenticated => SharedPreferencesHelper.getBool(Const.AUTHENTICATED);

  static Future setAuthenticated(bool value) => SharedPreferencesHelper.setBool(Const.AUTHENTICATED, value);

  static Future<bool> get isFirstTime => SharedPreferencesHelper.getBool(Const.IS_FIRST_TIME, defaultValue: true);

  static Future setIsFirstTime(bool value) => SharedPreferencesHelper.setBool(Const.IS_FIRST_TIME, value);

  static Future<String> get passcode => SharedPreferencesHelper.getString(Const.PASSCODE);

  static Future setPasscode(String value) => SharedPreferencesHelper.setString(Const.PASSCODE, value);

  Future<void> clear() async {
    await Future.wait(<Future>[
      setAuthenticated(false),
      setPasscode(''),
    ]);
  }
}