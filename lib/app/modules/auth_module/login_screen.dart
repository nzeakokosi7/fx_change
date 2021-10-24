import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/input.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: loginBackgroundColor,
      body: Stack(
        children: [
          Form(
            key: _key,
            child: Container(
              height: 1.0.ofHeight,
              padding: const EdgeInsets.only(top: 80.0, bottom: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: 0.2.ofHeight,
                      width: 0.5.ofWidth,
                      child: Image.asset("assets/images/logo.png",
                          fit: BoxFit.fill),
                    ),
                  ),
                  Space.Y(30.0),
                  SizedBox(
                    width: 0.8.ofWidth,
                    child: Text(
                      "Login",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Space.Y(30.0),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Input(
                          controller: P.auth.email,
                          prefixIcon: IconButton(icon: Image.asset("assets/icons/email.png"), onPressed: () {},),
                          label: 'Email',
                          type: InputType.email,
                          validator: (v) => v!.isEmail
                              ? null
                              : "Email is poorly formatted",
                        ),
                        Space.Y(20),
                        Container(
                          height: 1,
                          width: 1.0.ofWidth,
                          color: const Color(0xFFE5E7F3),
                        ),
                        Space.Y(20),
                        Input(
                          controller: P.auth.password,
                          prefixIcon: IconButton(icon: Image.asset("assets/icons/password.png"), onPressed: () {},),
                          label: 'Password',
                          type: InputType.password,
                          validator: (v) => v!.trim().length < 6
                              ? "Password must be at least 6 characters"
                              : null,
                        ),
                      ],
                    ),
                  ),
                  Space.Y(20),
                  Obx(()=> Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: TextButton(
                              onPressed: ()=> Get.toNamed(Routes.PASSWORD_RESET),
                              child: Text(
                                "Forgot Password?",
                                style: textButtonStyle,
                              )
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Press.dark(
                              "Login",
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  P.auth.login(navigate: true);
                                }
                              },
                              loading: P.auth.loading.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Color(0xFF9395A4)),
                      ),
                      TextButton(
                          onPressed: ()=> Get.toNamed(Routes.REGISTER),
                          child: Text(
                            "Register",
                            style: textButtonStyle,
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
