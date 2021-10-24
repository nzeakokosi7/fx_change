import 'dart:ui';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {

  const ActionWidget({
    Key? key,
    required this.imageAsset,
    required this.caption,
    required this.backgroundColor
  }) : super(key: key);

  final String imageAsset;
  final String caption;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 0.43.ofWidth,
      padding: EdgeInsets.only(left: 0.045.ofWidth),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(30)
      ),
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
            ),
            child: Center(
                child: Image.asset(imageAsset, scale: 1.5,)
            ),
          ),
          Space.X(10),
          Text(
            caption,
            style: subTitleStyle,
          )
        ],
      ),
    );
  }
}