import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/button.dart';
import 'package:first_ally_demo/app/global_widgets/input.dart';
import 'package:first_ally_demo/app/global_widgets/marquee_text.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankDialogue extends StatelessWidget {
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(()=> SizedBox(
      height: 450,
      child: Form(
        key: _key,
        child: Column(
          children: [
            Text(
              "Add A Bank Account",
              style: midiBoldStyle,
            ),
            Space.Y(30),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  hint: const Text("Select "),
                  onChanged: (selectedBank) {
                    P.account.selectedBank = selectedBank;
                  },
                  value: P.account.selectedBank,
                  items: P.account.bankListResponse.data!.map((selectedBank) {
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
                  controller: P.account.accountNo,
                  label: 'Account number',
                  type: InputType.number,
                  maxLength: 10,
                  validator: (v) => v!.trim().length == 10
                      ? null
                      : "Account Number must be 11 in number",
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
                          P.account.accName.value,
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
            SizedBox(
              width: 200,
              child: Press.dark(
                "Add",
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    P.account.addAccount();
                  }
                },
                loading: P.account.loading.value,
              ),
            )
          ],
        ),
      ),
    ));
  }

}