import 'dart:math';
import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/core/theme/text_theme.dart';
import 'package:first_ally_demo/app/global_widgets/space.dart';
import 'package:first_ally_demo/app/core/utils/utils.dart';
import 'package:first_ally_demo/app/modules/dashboard_module/widgets/action_widget.dart';
import 'package:first_ally_demo/app/modules/dashboard_module/widgets/trending_currency_widgets.dart';
import 'package:first_ally_demo/app/routes/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {

  var colorList = [
    const Color(0xFFFFE4C3),
    const Color(0xFFE0E2FF),
    const Color(0xFFFFE4EF),
    const Color(0xFFD5EEC9),
  ];

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
              alignment: Alignment.topLeft,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 25.0, left: 20.0, top: 50.0),
                child: Text(
                  "Home",
                  style: titleStyle,
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.6,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: [1, 2, 3, 4, 5].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: const EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: white,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: colorList[Random().nextInt(colorList.length)],
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "\$",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Text(
                                          "ETH",
                                          style: miniStyle
                                      ),
                                      Space.X(20),
                                      Text(
                                          "4.4%",
                                          style: miniStyle
                                      )
                                    ],
                                  ),
                                  Space.Y(10),
                                  Text(
                                      "\$32,128.80",
                                      style: subTitleStyle
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Space.Y(60),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Actions",
                        style: subTitleStyle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: ()=> ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Coming soon"),
                                )),
                                child: const ActionWidget(imageAsset: "assets/icons/watchlist.png", caption: "WatchList", backgroundColor: Color(0xFFDEF5E9)),
                              ),
                              GestureDetector(
                                onTap: ()=> Get.toNamed(Routes.CONVERSION),
                                child: const ActionWidget(imageAsset: "assets/icons/convert.png", caption: "Convert", backgroundColor: Color(0xFFFFEBE4)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: ()=> ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Coming soon"),
                                )),
                                child: const ActionWidget(imageAsset: "assets/icons/compare.png", caption: "Compare", backgroundColor: Color(0xFFDFF0FF)),
                              ),
                              GestureDetector(
                                onTap: ()=> ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Coming soon"),
                                )),
                                child: const ActionWidget(imageAsset: "assets/icons/price_alert.png", caption: "Price Alert", backgroundColor: Color(0xFFEBECFF)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 1.0.ofWidth,
                      padding: const EdgeInsets.only(left: 25, top:20, right: 25),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(35),
                              topLeft: Radius.circular(35)
                          )
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trending",
                            style: subTitleStyle,
                            textAlign: TextAlign.start,
                          ),
                          Space.Y(20),
                          ListView.builder(
                              itemCount: 20,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index){
                                return TrendingCurrencyWidget();
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
