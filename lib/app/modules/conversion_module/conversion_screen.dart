import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/custom_dialog.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/modules/conversion_module/widgets/in_app_keypad.dart';
import 'package:first_ally_demo/app/modules/conversion_module/widgets/recipient_dialogue.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: 1.0.ofWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 25.0, left: 20.0, top: 50.0),
                  child: Row(
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Convert",
                            style: titleStyle,
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Space.Y(20),
                Container(
                  height: 150,
                  width: 0.8.ofWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(()=> SizedBox(
                        width: 90,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            hint: const Text("Select "),
                            onChanged: (selectedCurrency) {
                              P.conversion.selectedCurrency = selectedCurrency;
                            },
                            value: P.conversion.selectedCurrency,
                            items: P.conversion.getSupportedCurrencies().map((selectedCurrency) {
                              return DropdownMenuItem(
                                child: Text(
                                  selectedCurrency.abbr!,
                                  style: titleStyle,
                                ),
                                value: selectedCurrency.symbol!,
                              );
                            }).toList(),
                          ),
                        ),
                      )),
                      Expanded(
                        child: TextField(
                          controller: P.conversion.inAppTextController,
                          style: subTitleStyle,
                          autofocus: true,
                          showCursor: true,
                          readOnly: true,
                          textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                Space.Y(30),
                SizedBox(
                  height: 50,
                  width: 0.8.ofWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To pay in Naira",
                        style: midiStyle,
                      ),
                      Obx(()=> Text(
                        "NGN " + P.conversion.nairaValue.value,
                        style: subTitleStyle,
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0.05.ofHeight),
                    padding: const EdgeInsets.only(left:20, right:20),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35)
                        )
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: InAppKeyboard(
                            onTextInput: (myText) {
                              P.conversion.insertText(myText);
                            },
                            onBackspace: () {
                              P.conversion.backspace();
                            },
                          ),
                        ),
                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            decoration: const BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0x20191C32),
                                      blurRadius: 15.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(20.0, 30.75)
                                  )
                                ],
                            ),
                            padding: const EdgeInsets.only(left: 30.0, bottom: 10, right: 30.0),
                            margin: const EdgeInsets.only(bottom: 40),
                            child: Press.light(
                              "Buy",
                              onPressed: () async {
                                if(P.conversion.accounts!.isNotEmpty) {

                                  if(P.conversion.inAppTextController.text.isNotEmpty){
                                    P.showProcessNotice(context);
                                    await P.conversion.fetchBankList();
                                    P.hideProcessNotice(context);

                                    showDialog<bool>(
                                        context: context,
                                        builder: (_) => CustomDialog(
                                          showPadding: false,
                                          child: RecipientDialogue(),
                                        ),
                                    );
                                  } else {
                                    Get.snackbar('Error', "You must enter a valid amount",
                                        backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
                                  }

                                } else {
                                  Get.snackbar('Error', "You must add at least one bank account",
                                      backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
                                  await Future.delayed(const Duration(milliseconds: 1500));
                                  P.home.selectedIndex = 2;
                                  Get.toNamed(Routes.HOME);
                                }
                              }
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}