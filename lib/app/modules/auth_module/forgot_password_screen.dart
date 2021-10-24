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


class PasswordResetScreen extends StatelessWidget {

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
                      "Password Recovery",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Space.Y(30.0),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Input(
                      controller: P.auth.email,
                      prefixIcon: IconButton(icon: Image.asset("assets/icons/email.png"), onPressed: () {},),
                      hint: 'Email',
                      type: InputType.email,
                      validator: (v) => v!.isEmail
                          ? null
                          : "Email is poorly formatted",
                    ),
                  ),
                  Space.Y(20),
                  Obx(()=> Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SizedBox(
                        width: 120,
                        child: Press.dark(
                          "Send Email",
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              P.auth.sendPasswordResetEmail();
                            }
                          },
                          loading: P.auth.loading.value,
                        ),
                      )
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
