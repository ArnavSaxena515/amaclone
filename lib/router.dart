import 'package:amaclone/common/widgets/navbar.dart';
import 'package:amaclone/features/address/screens/address_screen.dart';
import 'package:amaclone/features/admin/screens/add_product_screen.dart';
import 'package:amaclone/features/authentication/screens/auth_screen.dart';
import 'package:amaclone/features/home/screens/category_screen.dart';
import 'package:amaclone/features/home/screens/home_screens.dart';
import 'package:amaclone/features/order_details/screens/order_details_screen.dart';
import 'package:amaclone/features/product_details/screens/product_details_screen.dart';
import 'package:amaclone/features/search/screens/search_screen.dart';
import 'package:amaclone/models/order.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

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
      return MaterialPageRoute(builder: (_) => const AddProductScreen());

    case CategoryScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryScreen(category: category));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));

    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product));

    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments.toString() ;
      return MaterialPageRoute(builder: (_)=> AddressScreen(totalAmount: totalAmount,));

    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(builder: (_)=> OrderDetailScreen(order: order));

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
