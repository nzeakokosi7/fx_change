import 'package:first_ally_demo/app/modules/account_module/account_information_screen.dart';
import 'package:first_ally_demo/app/modules/account_module/account_settings_screen.dart';
import 'package:first_ally_demo/app/modules/account_module/change_password_screen.dart';
import 'package:first_ally_demo/app/modules/auth_module/forgot_password_screen.dart';
import 'package:first_ally_demo/app/modules/auth_module/login_screen.dart';
import 'package:first_ally_demo/app/modules/auth_module/register_screen.dart';
import 'package:first_ally_demo/app/modules/conversion_module/conversion_screen.dart';
import 'package:first_ally_demo/app/modules/home_module/home_screen.dart';
import 'package:first_ally_demo/app/modules/onboarding_module/onboarding_screen.dart';
import 'package:first_ally_demo/app/modules/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
part './routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => Splash()),
    GetPage(name: Routes.INTRO, page: () => OnBoardingScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.CONVERSION, page: () => ConversionScreen()),
    GetPage(name: Routes.ACCOUNT_SETTING, page: () => AccountSetting()),
    GetPage(name: Routes.CHANGE_PASSWORD, page: () => PasswordChange()),
    GetPage(name: Routes.ACCOUNT_INFO, page: () => AccountInformation()),
    GetPage(name: Routes.PASSWORD_RESET, page: () => PasswordResetScreen()),
  ];
}