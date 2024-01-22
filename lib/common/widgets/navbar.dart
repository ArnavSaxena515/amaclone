import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/account/screens/accounts_screen.dart';
import '../../features/cart/screens/cart_screen.dart';
import 'package:amaclone/features/home/screens/home_screens.dart';
// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatefulWidget {
  static const String routeName = '/actual-home';

  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _page = 0;
  final double navBarWidth = 42;
  final double navBarBorderWidth = 5;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen()
  ];

  void _updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  // todo  implement animation for transitioning from screen to screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GNav(
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
                text: 'Home',
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Account',
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: 'Cart',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
