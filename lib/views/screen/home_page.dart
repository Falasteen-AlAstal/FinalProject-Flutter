import 'package:flutter/material.dart';
import 'package:flutter_final_project/views/screen/profile.dart';

import '../../bottom_nav_bar.dart';
import '../../models/categories.dart';
import 'cart.dart';
import 'home.dart';
import 'meals.dart';

class HomePages extends StatefulWidget {
  const HomePages({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _pages => [
        HomePage(),
        ShopPage(),
        ProfilePage(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChhange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
