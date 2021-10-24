import 'dart:math';
import 'dart:ui';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendingCurrencyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var trendingColorList = [
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
              color: trendingColorList[Random().nextInt(trendingColorList.length)],
            ),
            child: Center(
              child: Text(
                "\$",
                style: TextStyle(
                    color: white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Space.X(20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ByteCoin",
                style: mediumStyle,
              ),
              Text(
                "BCN",
                style: miniStyle,
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$15,313.81",
                style: mediumStyle,
              ),
              Text(
                "2.2%",
                style: miniStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}