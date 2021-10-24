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


class RegisterScreen extends StatelessWidget {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
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
                      "Register",
                      style: titleStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Space.Y(30.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Input(
                              controller: P.auth.fullName,
                              prefixIcon: IconButton(icon: Image.asset("assets/icons/user.png"), onPressed: () {},),
                              hint: 'Full name',
                              type: InputType.text,
                              validator: (v) => v!.isNotEmpty
                                  ? null
                                  : "Full name cannot be empty",
                            ),
                            Space.Y(20),
                            Input(
                              controller: P.auth.email,
                              prefixIcon: IconButton(icon: Image.asset("assets/icons/email.png"), onPressed: () {},),
                              hint: 'Email',
                              type: InputType.email,
                              validator: (v) => v!.isEmail
                                  ? null
                                  : "Email is poorly formatted",
                            ),
                            Space.Y(20),
                            Input(
                              controller: P.auth.phone,
                              prefixIcon: IconButton(icon: Image.asset("assets/icons/email.png"), onPressed: () {},),
                              hint: 'Phone',
                              type: InputType.number,
                              validator: (v) => v!.trim().length < 11
                                  ? "Contact must be at least 11 characters"
                                  : null,
                            ),
                            Space.Y(20),
                            Input(
                              controller: P.auth.password,
                              prefixIcon: IconButton(icon: Image.asset("assets/icons/password.png"), onPressed: () {},),
                              hint: 'Password',
                              type: InputType.password,
                              validator: (v) => v!.trim().length < 6
                                  ? "Password must be at least 6 characters"
                                  : null,
                            ),
                            Space.Y(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Obx(()=> Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Press.dark(
                        "Register",
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            P.auth.register();
                          }
                        },
                        loading: P.auth.loading.value,
                      ),
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Color(0xFF9395A4)),
                      ),
                      TextButton(
                          onPressed: ()=> Get.toNamed(Routes.LOGIN),
                          child: Text(
                            "Login",
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
