
import 'dart:ui';

import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xEEF3E9FF), Color(0xEEF3E9FF)]),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 50.0,
                      sigmaY: 50.0,
                    ),
                    child: Text(".")
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        loginBackgroundColor,
                        const Color(0xEEFFC2C6),
                        const Color(0xEEFFC2C6)]),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 40.0,
                      sigmaY: 40.0,
                    ),
                    child: Text(".")
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: 100,
                width: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        loginBackgroundColor,
                        const Color(0xEEFFE3C9),
                        const Color(0xEEFFE3C9)]),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 40.0,
                      sigmaY: 40.0,
                    ),
                    child: Text(".")
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 50.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 7),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 30),
                        onPressed: () => Get.toNamed(Routes.HOME),
                      ),
                    ),
                    Space.X(20.0),
                    Text(
                      "Settings",
                      style: titleStyle,
                    )
                  ],
                ),
                Space.Y(50.0),
                GestureDetector(
                  onTap: () {
                    P.account.setUserInfo();
                    Get.toNamed(Routes.ACCOUNT_INFO);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.all(8.0),
                      height: 60,
                      width: 1.0.ofWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Account Information",
                            style: mediumStyle,
                          ),
                         const Icon(Icons.arrow_forward_ios)
                        ],
                      )),
                ),
                Space.Y(20.0),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.CHANGE_PASSWORD),
                  child: Container(
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.all(Radius.circular(5))),
                      padding: const EdgeInsets.all(8.0),
                      height: 60,
                      width: 1.0.ofWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style: mediumStyle
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      )),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    "PRIVACY POLICY",
                    style: midiBoldStyle
                  ),
                ),
                Space.Y(15.0),
                Center(
                  child: Text(
                    "VERSION 1.0",
                    style: midiBoldStyle,
                  ),
                ),
                Space.Y(50.0),
                Center(
                  child:Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Press.dark(
                      "Sign Out",
                      onPressed: () => P.auth.signOut(),
                      loading: P.auth.loading.value,
                    ),
                  ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
