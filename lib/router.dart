import 'package:amaclone/common/widgets/navbar.dart';
import 'package:amaclone/features/admin/screens/add_product_screen.dart';
import 'package:amaclone/features/authentication/screens/auth_screen.dart';
import 'package:amaclone/features/home/screens/home_screens.dart';
import 'package:flutter/material.dart';

//route settings contains info needed to make routes
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // map route settings with a case
    // if name is the routeName for authScreen, generate a route for the auth screen
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case Navbar.routeName:
      return MaterialPageRoute(builder: (_) => const Navbar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_)=>const AddProductScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                //TODO: customise this error screen
                body: Center(
                  child: Text("Screen does not exist"),
                ),
              ));
  }
}
