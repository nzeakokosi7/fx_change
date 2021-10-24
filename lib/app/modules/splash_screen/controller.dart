import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:first_ally_demo/app/services/_auth.dart';
import 'package:first_ally_demo/app/services/prefs.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  /// Move from loader to splash after 5 seconds
  Future<void> delayedMove({int milli = 2000, String? to}) async {
    await Future.delayed(Duration(milliseconds: milli));
    Prefs.isFirstTime.then(
            (value) => value ? Get.offAllNamed(Routes.INTRO)
                             : Get.offAllNamed(to ?? Routes.LOGIN)
    );
  }

  @override
  void onInit() {
    super.onInit();

    if (AuthService.isLoggedIn()) {
       delayedMove(to: Routes.HOME);
    } else {
      delayedMove();
    }
  }
}
