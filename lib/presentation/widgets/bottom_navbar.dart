import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:rafsakaos_app/presentation/pages/homepage.dart';
import 'package:rafsakaos_app/presentation/pages/katalogPage.dart';
import 'package:rafsakaos_app/presentation/pages/orderPage.dart';
import 'package:rafsakaos_app/presentation/pages/profilePage.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int pageIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    KatalogPage(),
    OrderPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: pages[pageIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: Colors.white,
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          final iconData = index == 0
              ? CupertinoIcons.home
              : index == 1
                  ? CupertinoIcons.square_grid_2x2
                  : index == 2
                      ? CupertinoIcons.cart
                      : CupertinoIcons.person;

          final label = index == 0
              ? 'Home'
              : index == 1
                  ? 'Katalog'
                  : index == 2
                      ? 'Order'
                      : 'Profile';

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 25,
                color: isActive ? const Color(0xFF2C5A33) : Colors.black,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: isActive ? const Color(0xFF2C5A33) : Colors.black,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        },
        activeIndex: pageIndex,
        gapLocation: GapLocation.none, // 4 item → no FAB di tengah
        notchSmoothness: NotchSmoothness.defaultEdge,
        elevation: 0,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        gapWidth: 0,
      ),
    );
  }
}
