import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Center(
              child: SizedBox(
                height: 300.0,
                child: Column(
                  children: [
                    Image.asset("assets/images/logo.png"),
                    Space.Y(10.0),
                    Text(
                      "First Ally FXchange",
                      style: subTitleStyle,
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
