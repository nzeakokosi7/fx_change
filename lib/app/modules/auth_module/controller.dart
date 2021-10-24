import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/utils/firebase_response.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:first_ally_demo/app/services/_auth.dart';
import 'package:first_ally_demo/app/services/_database.dart';
import 'package:first_ally_demo/app/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_ally_demo/app/data/models/user.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  RxMap typeMap = RxMap<String, bool>();

  RxBool loading = false.obs;
  RxBool incompleteUserData = false.obs;

  final bool navigate = false;
  Rx<User>? user;

  void addUserData() async {
    await DatabaseService.storeUser(User()
      ..id = AuthService.user!.uid
      ..fullName = fullName.text
      ..email = email.text
      ..phone = phone.text
    );
  }

  void updateTypeMap(String type) {
    typeMap.update(type, (value) => !value);
  }

  Future<void> register() async {
    loading.value = true;
    NetworkResponse<bool> authR =
    await AuthService.register(email.text, password.text);
    loading.value = true;
    if (authR.verify()) {
      await login();
      addUserData();
      Prefs.setAuthenticated(true);
      Prefs.setIsFirstTime(false);
      await login(navigate: true);
    }
    loading.value = false;
  }

  Future<void> login({bool navigate = false}) async {
    loading.value = true;
    NetworkResponse<bool> authR =
    await AuthService.login(email.text, password.text);
    if (authR.verify()) {
      if (navigate) {

        P.account.initialise();
        Get.offAllNamed(Routes.HOME);
        Prefs.setIsFirstTime(false);
        P.conversion.initialise();

        loading.value = false;
        email.text = password.text = "";
      }
      loading.value = false;
    }
    loading.value = false;
  }

  Future<void> sendPasswordResetEmail() async {
    loading.value = true;
    NetworkResponse<bool> res =
    await AuthService.resetPassword(email.text);
    if (res.verify()) {
      Get.snackbar('Success', "Email has been sent successfully!",
          backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      loading.value = false;
      await Future.delayed(const Duration(milliseconds: 1500));
      Get.offAllNamed(Routes.LOGIN);
    }
    loading.value = false;
  }

  Future<void> signOut() async {
    await AuthService.signOut();
  }

}
