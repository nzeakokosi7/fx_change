import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_ally_demo/app/core/utils/firebase_response.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:get/get.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static User? get user => _auth.currentUser;

  static Future<NetworkResponse<bool>> login(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return NetworkResponse(true);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> register(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return NetworkResponse(true);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> changePassword(
      String oldPassword, String newPassword) async {

    try {

      await _auth.signInWithEmailAndPassword(
        email: user!.email!,
        password: oldPassword,
      );

      await user!.updatePassword(newPassword);
      print("success");
      return NetworkResponse(true);

    } catch (e) {
      print(e.toString());
      return NetworkResponse(false, error: e.toString());
    }
  }

  static Future<NetworkResponse<bool>> resetPassword(String email) async {

    try {
      await _auth.sendPasswordResetEmail(email: email);
      return NetworkResponse(true);
    } catch (e) {
      return NetworkResponse(false, error: e.toString());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  static bool isLoggedIn() {
    return user != null;
  }

}
