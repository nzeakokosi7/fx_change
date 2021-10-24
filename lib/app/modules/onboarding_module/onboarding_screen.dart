import 'dart:ui';

import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/marquee_text.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {

  final List<Map> presentation = [
    {
      "text": "A little walk through",
      "subtext": "For the purpose of this demo, only the 'Convert' action bubble is live, "
          "on your account screen all basic account functionalities can be accessed by tapping Preferences."
          " Tapping Help would replay this guide again, Account security is non functional. "
          "Please be advised that the currency charts are not real and the currencies found in this guide might vary from what is obtainable in the app.",
      "image": "assets/gifs/walk_through.gif"
    },
    {
      "text": "Adding A Bank Account",
      "subtext": "Your bank accounts are where your USD, GPD or EUR would be paid into. You must add at least one.",
      "image": "assets/gifs/add_account.gif"
    },
    {
      "text": "Buying a currency",
      "subtext": "To buy a currency, click on the 'Convert' action bubble on your homepage, "
          "select your desired currency from the drop down, enter the desired amount, then click buy to select or enter the destination account. "
          "After which you'd click proceed , which then inflates the paystack card payment portal, you can use the test card found in this demo; "
          "or the one in the README.md file on at the root folder of the project on github. "
          "NB: Make sure the currency of the destination account tallies with your selected currency as it has higher priority.",
      "image": "assets/gifs/convert_currency.gif"
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: Obx(() => Stack(
        children: [
          Container(
            height: 280,
            width: 250,
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xEEFFC2C6), Color(0xEEE8D5FF)]),
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xEEFFEBE4), Color(0xEEFFEBE4)]),
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
              alignment: Alignment.centerRight,
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        loginBackgroundColor,
                        const Color(0xEEFFE4EF),
                        const Color(0xEEFFE4EF)]),
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
          Column(
            children: [
              SizedBox(
                height: 0.5.ofHeight,
                child: Image.asset(presentation[P.intro.selectedIndex]["image"]),
              ),
              Container(
                height: 50.0,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                      presentation.length,
                          (index) => AnimatedContainer(
                        margin: const EdgeInsets.only(right: 4, left: 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == P.intro.selectedIndex
                                ? mediumTextColor
                                : titleColor
                        ),
                        duration: const Duration(milliseconds: 500),
                        height: 10,
                        width: 10,
                      )
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          presentation[P.intro.selectedIndex]["text"],
                          style: subTitleStyle,
                          textAlign: TextAlign.center,
                        ),
                        Space.Y(20),
                        Expanded(
                          child: MarqueeWidget(
                            direction: Axis.vertical,
                            pauseDuration: const Duration(milliseconds: 4000),
                            child: Text(
                              presentation[P.intro.selectedIndex]["subtext"],
                              style: midiStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Space.Y(20),
                        SizedBox(
                          height: 50,
                          child: Press.dark(
                            P.intro.selectedIndex == 2 ? "Proceed to register" : "Next",
                            onPressed: () => P.intro.selectedIndex < presentation.length - 1
                                ? P.intro.selectedIndex += 1
                                : Get.offAllNamed(Routes.REGISTER),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                            child: P.intro.selectedIndex < 2
                                ? TextButton(
                              child: Text(
                                "Skip",
                                style: midiStyle,
                              ),
                              onPressed: ()=> Get.offAllNamed(Routes.LOGIN),
                            )
                                : Row(
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
                        ),
                        Space.Y(20)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: P.intro.selectedIndex == 0
                  ? const Text("")
                  : Container(
                margin: const EdgeInsets.only(top: 50, left: 30),
                padding: const EdgeInsets.only(left: 7),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.all(Radius.circular(12))),
                height: 50,
                width: 50,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 30),
                  onPressed: () => P.intro.selectedIndex -= 1,
                ),
              ))
        ],
      )),
    );
  }

}