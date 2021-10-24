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
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';

class RecipientDialogue extends StatelessWidget {

  static final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=> SizedBox(
      height: 550,
      child: Column(
        children: [
          Text(
            "Select Recipient",
            style: midiBoldStyle,
          ),
          Space.Y(20),
          FlutterToggleTab(
            width: 50,
            borderRadius: 15,
            selectedTextStyle: subTitleStyle,
            unSelectedTextStyle: midiStyle,
            selectedBackgroundColors: [white],
            labels: ["Myself", "Another"],
            selectedIndex: P.conversion.selectedIndex,
            selectedLabelIndex: (index) => P.conversion.selectedIndex = index,
          ),
          Space.Y(30),
          Obx(()=> P.conversion.selectedIndex == 0
              ?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Container(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                          Radius.circular(5.0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const Text("Select "),
                        onChanged: (selectedBank) {
                          P.conversion.selectedBank = selectedBank;
                        },
                        value: P.conversion.selectedBank,
                        items: P.conversion.accounts!.map((selectedBank) {
                          return DropdownMenuItem(
                            child: Text(
                              selectedBank.currencySymbol! + " :" + selectedBank.financialInstitution! +" - "+selectedBank.accountName!,
                            ),
                            value: selectedBank.id!,
                          );
                        }).toList(),
                      ),
                    ),
                  )),
                  Space.Y(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Currency',
                        style: midiStyle,
                      ),
                      Space.Y(5),
                      Text(
                        P.conversion.getAccountWithId(P.conversion.selectedBank).currency!,
                        style: subTitleStyle,
                      ),
                      Space.Y(10),
                      Text(
                        'Financial Institution',
                        style: midiStyle,
                      ),
                      Space.Y(5),
                      Text(
                        P.conversion.getAccountWithId(P.conversion.selectedBank).financialInstitution!,
                        style: subTitleStyle,
                      ),
                      Space.Y(10),
                      Container(
                        height: 1,
                        width: 1.0.ofWidth,
                        color: const Color(0xFFE5E7F3),
                      ),
                      Space.Y(10),
                      Text(
                        'Account Number',
                        style: midiStyle,
                      ),
                      Space.Y(5),
                      Text(
                        P.conversion.getAccountWithId(P.conversion.selectedBank).accountNumber!,
                        style: subTitleStyle,
                      ),
                      Space.Y(10),
                      Container(
                        height: 1,
                        width: 1.0.ofWidth,
                        color: const Color(0xFFE5E7F3),
                      ),
                      Space.Y(10),
                      Text(
                        'Account Name',
                        style: midiStyle,
                      ),
                      Space.Y(5),
                      MarqueeWidget(
                          direction: Axis.horizontal,
                          child: Text(
                            P.conversion.getAccountWithId(P.conversion.selectedBank).accountName!,
                            style: subTitleStyle,
                          )
                      ),
                    ],
                  ),
                ],
              )
              :
              Form(
                key: _key,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text("Select "),
                          onChanged: (selectedBank) {
                            P.conversion.selectedBankFromPaystack = selectedBank;
                          },
                          value: P.conversion.selectedBankFromPaystack,
                          items: P.conversion.bankListResponse.data!.map((selectedBank) {
                            return DropdownMenuItem(
                              child: Text(
                                selectedBank.name!,
                                style: mediumStyle,
                              ),
                              value: selectedBank.name!,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Space.Y(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
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
                                    selectedCurrency.fullName!,
                                    style: mediumStyle,
                                  ),
                                  value: selectedCurrency.symbol!,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Space.Y(30),
                        Input(
                          controller: P.conversion.accountNo,
                          label: 'Account number',
                          type: InputType.number,
                          maxLength: 10,
                          validator: (v) => v!.trim().length == 10
                              ? null
                              : "Account Number must be 10 in number",
                        ),
                        Space.Y(25),
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account Name",
                                style: midiStyle,
                              ),
                              MarqueeWidget(
                                  direction: Axis.horizontal,
                                  child: Text(
                                    P.conversion.accName.value,
                                    style: mediumStyle,
                                  )
                              ),
                            ],
                          ),
                        ),
                        Space.Y(5),
                      ],
                    ),
                    Space.Y(10),
                  ],
                ),
              )
          ),
          Space.Y(10),
          SizedBox(
            width: 200,
            child: Press.dark(
              "Proceed",
              onPressed: () {
                if(P.conversion.selectedIndex == 1) {
                  if (_key.currentState!.validate()) {
                    P.conversion.charge(context);
                  }
                } else {
                  P.conversion.charge(context);
                }
              },
              loading: P.conversion.loading.value,
            ),
          ),
        ],
      ),
    ));
  }

}