import 'dart:convert';
import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/models/user.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';

class AddressServices {
  final BuildContext context;

  AddressServices({required this.context});

  void saveUserAddress({
    required String address,
  }) async {
    try {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      http.Response response =
          await http.post(Uri.parse('$uri/api/user/save-user-address'),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'address': address}));

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(response.body)['address']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({required String address, required double totalSum}) async {
    try {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      http.Response response = await http.post(Uri.parse('$uri/api/user/order'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          }));

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Your order has been placed");
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      showSnackBar(context, e.toString());
    }
  }
}
