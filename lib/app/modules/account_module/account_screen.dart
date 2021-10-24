import 'dart:math';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/custom_dialog.dart';
import 'package:first_ally_demo/app/global_widgets/marquee_text.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/modules/account_module/widgets/add_bank_dialogue.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountScreen extends StatelessWidget {

  var colorList = [
    const Color(0xFF118AB2),
    const Color(0xFF66DD66),
    const Color(0xFF2EC4B6),
    const Color(0xFF44CCCC),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: loginBackgroundColor,
      body: Stack(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 20.0, top: 50.0),
                child: Row(
                  children: [
                    Text(
                      "Account",
                      style: titleStyle,
                    ),
                  ],
                ),
              ),
              Space.Y(20),
              Container(
                height: 150,
                width: 0.8.ofWidth,
                padding: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: const Color(0xFFFF9BB3),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: Image.asset("assets/images/profile_robot.png")
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.48.ofWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MarqueeWidget(
                            direction: Axis.horizontal,
                            child: Text(
                              P.account.user!.value.fullName!,
                              style: profileNameStyle,
                            ),
                          ),
                          Space.Y(10),
                          MarqueeWidget(
                            direction: Axis.horizontal,
                            child: Text(
                              P.account.user!.value.email!,
                              style: profileEmailStyle,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Space.Y(50),
              Expanded(
                child: Container(
                  width: 1.0.ofWidth,
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF7F7FA),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35)
                      )
                  ),
                  child: Column(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        child: GestureDetector(
                          onTap: () async {
                            P.showProcessNotice(context);
                            await P.account.fetchBankList();
                            P.hideProcessNotice(context);

                            showDialog<bool>(
                              context: context,
                              builder: (_) => CustomDialog(
                                showPadding: false,
                                child: AddBankDialogue(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset("assets/icons/bank_account.png", scale: 1.5),
                              Space.X(30),
                              Text(
                                "Bank Account",
                                style: mediumStyle,
                              ),
                              const Spacer(),
                              const  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                            ],
                          ),
                        ),
                      ),
                      Obx(()=> P.account.accounts!.isEmpty
                          ?
                          Space.Y(1)
                          :
                          CarouselSlider(
                        options: CarouselOptions(
                          height: 130,
                          aspectRatio: 16 / 9,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          reverse: false,
                          autoPlay: false,
                          autoPlayAnimationDuration: const Duration(milliseconds: 800),
                          scrollDirection: Axis.horizontal,
                        ),
                        items: P.account.accounts!.map((account) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                onTap: () {
                                  final snackBar = SnackBar(
                                    content: const Text('Would you like to remove this bank account?'),
                                    action: SnackBarAction(
                                      label: 'Yes',
                                      onPressed: () {
                                        P.account.removeBank(account);
                                      },
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  margin: const EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0, bottom: 15.0),
                                  decoration: BoxDecoration(
                                    color: white,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorList[Random().nextInt(colorList.length)],
                                        ),
                                        child: Center(
                                          child: Text(
                                            account.currencySymbol!,
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                      Space.X(20),
                                      SizedBox(
                                        width: 0.4.ofWidth,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            MarqueeWidget(
                                              direction: Axis.horizontal,
                                              child: Text(
                                                account.financialInstitution!,
                                                style: midiBoldStyle,
                                              ),
                                            ),
                                            MarqueeWidget(
                                              direction: Axis.horizontal,
                                              child: Text(
                                                account.accountName!,
                                                style: midiStyle,
                                              ),
                                            ),
                                            MarqueeWidget(
                                                direction: Axis.horizontal,
                                                child: Text(
                                                  account.accountNumber!,
                                                  style: midiStyle,
                                                )
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        child: GestureDetector(
                          onTap: ()=> Get.toNamed(Routes.ACCOUNT_SETTING),
                          child: Row(
                            children: [
                              Image.asset("assets/icons/preferences.png", scale: 1.5),
                              Space.X(30),
                              Text(
                                "Preferences",
                                style: mediumStyle,
                              ),
                              const Spacer(),
                              const  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        child: Row(
                          children: [
                            Image.asset("assets/icons/security.png", scale: 1.5),
                            Space.X(30),
                            Text(
                              "Account Security",
                              style: mediumStyle,
                            ),
                            const Spacer(),
                            const  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.INTRO);
                            },
                          child: Row(
                            children: [
                              Image.asset("assets/icons/support.png", scale: 1.5),
                              Space.X(30),
                              Text(
                                "Help",
                                style: mediumStyle,
                              ),
                              const Spacer(),
                              const  Icon(Icons.arrow_forward_ios, color: Colors.grey)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Function? backAction;

  const MyCustomAppBar({Key? key, required this.height, this.backAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 25.0, left: 20.0, top: 50.0),
      child: Row(
        children: [
          Text(
            "Account",
            style: titleStyle,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}