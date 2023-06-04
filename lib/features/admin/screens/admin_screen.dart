import 'package:amaclone/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> pages = [
    const PostsScreen(),
    const Center(child: Text('Analytics'),),
    const Center(child: Text('Orders'),),
  ];
  int _page = 0;

  void _updatePage(int value) {
    setState(() {
      _page = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/amazon_in.png',
                      height: 50,
                      width: 120,
                      color: Colors.black,
                    )),
                const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      'Admin',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
        ),
        body: pages[_page],
        bottomNavigationBar: GNav(
          duration: const Duration(milliseconds: 400),
          selectedIndex: _page,
          activeColor: GlobalVariables.selectedNavBarColor,
          color: Colors.white,
          tabBackgroundColor: Colors.grey[900]!,
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8.0),
          //unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          rippleColor: GlobalVariables.unselectedNavBarColor,
          // backgroundColor: GlobalVariables.backgroundColor,
          backgroundColor: Colors.black,
          iconSize: 30,
          onTabChange: _updatePage,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Posts',
            ),
            GButton(
              icon: Icons.analytics_outlined,
              text: 'Analytics',
            ),
            GButton(
              icon: Icons.local_shipping_outlined,
              text: 'Orders',
            ),
          ],
        ),
    );
  }
}
