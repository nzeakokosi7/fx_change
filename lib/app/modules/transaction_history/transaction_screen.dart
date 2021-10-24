import 'dart:ui';
import 'package:first_ally_demo/app/modules/transaction_history/widgets/transaction_widget.dart';
import 'package:get/get.dart';
import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {

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
          Obx(()=> Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 25.0, left: 20.0, top: 50.0, bottom: 20.0),
                child: Text(
                  "Transaction History",
                  style: titleStyle,
                ),
              ),
              if(P.conversion.transactions!.isEmpty)
                const Center(
                  child: Text("You are yet to perform a transaction."),
                ),
              Expanded(
                child: ListView.builder(
                    itemCount: P.conversion.transactions!.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                P.conversion.transactions![index].date!,
                                style: midiStyle
                            ),
                            Space.Y(20),
                            Column(
                              children: P.conversion.transactions![index].transactions!.map((trx) => TransactionObject(trx: trx)).toList(),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ))
        ],
      ),
    );
  }
}
