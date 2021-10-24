import 'dart:math';
import 'dart:ui';
import 'package:first_ally_demo/app/data/models/transaction_history.dart';
import 'package:first_ally_demo/app/global_widgets/marquee_text.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionObject extends StatelessWidget {
  const TransactionObject({
    Key? key,
    required this.trx,
  }) : super(key: key);

  final Transactions trx;

  @override
  Widget build(BuildContext context) {

    var colorList = [
      const Color(0xFF118AB2),
      const Color(0xFF66DD66),
      const Color(0xFF2EC4B6),
      const Color(0xFF44CCCC),
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
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
                trx.currencySymbol!,
                style: TextStyle(
                    color: white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Space.X(10),
          SizedBox(
            width: 0.5.ofWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarqueeWidget(
                  direction: Axis.horizontal,
                  child: Text(
                    trx.accountName!,
                    style: mediumStyle,
                  ),
                ),
                Text(
                  trx.time! + " | "+ trx.status!,
                  style: miniStyle,
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                trx.currencySymbol!
                    + NumberFormat('#,###,###').format(int.parse(trx.amount!)/100),
                style: mediumStyle,
              ),
              Text(
                "NGN ${trx.rate!}/${trx.currencySymbol}",
                style: miniStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}