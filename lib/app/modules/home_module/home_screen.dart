import 'package:first_ally_demo/app/core/p.dart';
import 'package:first_ally_demo/app/core/theme/color_theme.dart';
import 'package:first_ally_demo/app/modules/account_module/account_screen.dart';
import 'package:first_ally_demo/app/modules/dashboard_module/dashboard_screen.dart';
import 'package:first_ally_demo/app/modules/transaction_history/transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  Widget buildChildren() {
    List<Widget> _children = [
      DashboardScreen(),
      TransactionScreen(),
      AccountScreen()
    ];
    return Obx(() => _children[P.home.selectedIndex]);
  }

  Widget buildBottomNavBar(BuildContext context) {
    return Obx(() => Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: white),
      child: SizedBox(
        height: 89,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0)
          ),
          child: BottomNavigationBar(
            elevation: 2.0,
            selectedItemColor: primary,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: P.home.selectedIndex, //
            onTap: (index) => P.home.selectedIndex =
                index, // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/home_inactive.png", scale: 2.0),
                  activeIcon: Image.asset("assets/icons/home_active.png", scale: 2.0),
                  label: ''
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/transactions_inactive.png", scale: 2.0),
                activeIcon: Image.asset("assets/icons/transactions_active.png", scale: 2.0),
                  label: ''
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/account_inactive.png", scale: 2.0),
                activeIcon: Image.asset("assets/icons/account_active.png", scale: 2.0),
                  label: ''
              ),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: loginBackgroundColor,
      body: buildChildren(),
      bottomNavigationBar: buildBottomNavBar(context),
      // endDrawer: buildDrawer(),
    );
  }
}