import 'package:get/get.dart';

class IntroController extends GetxController {
  final _selectedIndex = 0.obs;

  get selectedIndex => _selectedIndex.value;
  set selectedIndex(index) => _selectedIndex.value = index;

  final _isLoggedIn = false.obs;

  get isLoggedIn => _isLoggedIn.value;
  set isLoggedIn(value) => _isLoggedIn.value = value;
}
