import 'dart:ui';

import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/input.dart';
import 'package:first_ally_demo/app/global_widgets/marquee_text.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInformation extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 50.0, bottom: 50.0),
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
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Space.X(15),
                    SizedBox(
                      width: 0.68.ofWidth,
                      child: MarqueeWidget(
                        direction: Axis.horizontal,
                        child: Text(
                          "Account Information",
                          style: titleStyle,
                        ),
                      ),
                    )
                  ],
                ),
                Space.Y(40.0),
                SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: SizedBox(
                      height: 0.6.ofHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full name',
                                style: subTitleStyle
                              ),
                              Space.Y(5),
                              Input(
                                controller: P.account.fullName,
                                hint: 'Enter your full name',
                                type: InputType.text,
                                validator: (v) => v!.isNotEmpty
                                    ? null
                                    : "Full name cannot be empty",
                              ),
                            ],
                          ),
                          Space.Y(40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Phone Contact',
                                  style: subTitleStyle
                              ),
                              Space.Y(5),
                              Input(
                                controller: P.account.phone,
                                hint: 'Enter your phone contact here',
                                type: InputType.text,
                                validator: (v) => v!.isNotEmpty
                                    ? null
                                    : "Full name cannot be empty",
                              ),
                            ],
                          ),
                          Space.Y(40),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email',
                                style: subTitleStyle,
                              ),
                              Space.Y(5),
                              Container(
                                height: 50.0,
                                width: 1.0.ofWidth,
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                decoration: BoxDecoration(
                                  color: white,
                                  border: Border.all(
                                    color: white,
                                    width: 1.0,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)
                                  ),
                                ),
                                child: Text(
                                  P.account.user!.value.email!,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Space.Y(40)
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Obx(()=> Center(
                    child:Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Press.dark(
                        "Save changes",
                        onPressed: () => P.account.updateUser(),
                        loading: P.account.loading.value,
                      ),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
