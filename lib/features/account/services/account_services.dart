import 'dart:convert';

import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/features/authentication/screens/auth_screen.dart';
import 'package:amaclone/models/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../provider/user_provider.dart';

class AccountServices {
  final BuildContext context;
  late UserProvider userProvider;

  AccountServices({required this.context}) {
    userProvider = Provider.of<UserProvider>(context, listen: false);
  }

  Future<List<Order>> getOrders() async {
    List<Order> orders = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/user/order'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': userProvider.user.token,
      });

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            final temp = jsonDecode(response.body);

            for (int i = 0; i < temp.length; i++) {
              orders.add(Order.fromJson(temp[i]));
            }
            // for (int i = 0; i < temp['orders'].length; i++) {
            //   if (kDebugMode) {
            //     print(orders[i].id);
            //   }
            // }
          });

      return orders;
    } catch (e) {
      showSnackBar(context, e.toString());
      if (kDebugMode) {
        print(e.toString());
        print("Error");
      }
      return [];
    }
  }

  void logOut() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
