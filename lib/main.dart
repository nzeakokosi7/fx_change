import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'app/core/p.dart';
import 'app/modules/splash_screen/splash_screen.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Firebase.initializeApp().then((value) => P.initialize());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'First Ally',
      initialRoute: Routes.INITIAL,
      defaultTransition: Transition.fade,
      getPages: AppPages.pages,
      home: Splash(),
    );
  }
}
