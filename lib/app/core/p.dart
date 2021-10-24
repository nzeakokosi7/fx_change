import 'package:first_ally_demo/app/modules/account_module/controller.dart';
import 'package:first_ally_demo/app/modules/auth_module/controller.dart';
import 'package:first_ally_demo/app/modules/conversion_module/controller.dart';
import 'package:first_ally_demo/app/modules/home_module/controller.dart';
import 'package:first_ally_demo/app/modules/onboarding_module/controller.dart';
import 'package:first_ally_demo/app/modules/splash_screen/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P {
  static initialize() {
    Get.put(SplashController());
    Get.put(HomeController());
    Get.put(AccountController());
    Get.put(AuthController());
    Get.put(ConversionController());
    Get.put(IntroController());
    Get.put(HomeController());
  }

  static SplashController get splash => Get.find();
  static IntroController get intro => Get.find();
  static AuthController get auth => Get.find();
  static HomeController get home => Get.find();
  static ConversionController get conversion => Get.find();
  static AccountController get account => Get.find();

  static void showProcessNotice(BuildContext context) {
    const snackBar = SnackBar(
      duration: Duration(milliseconds: 10000),
      content: Text('Processing...'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideProcessNotice(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
