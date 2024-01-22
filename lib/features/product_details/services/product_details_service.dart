import 'dart:convert';

import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/models/user.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService {
  Future<void> rateProduct(
      {required BuildContext context, required Product product, required rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;

    try {
      final body = {
        "userId": userProvider.id,
        "rating": rating,
        "productId": product.id,
      };
      http.Response response =
          await http.post(Uri.parse('$uri/api/rate-product'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.token
      },body: jsonEncode(body));
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Rating added');

          });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addProductToCart({required Product product, required BuildContext context})async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
      final body = {
        "productId": product.id,
      };
      http.Response response =
      await http.post(Uri.parse('$uri/api/user/add-product-to-cart'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },body: jsonEncode(body));
      print(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
           // userProvider.cart.add(product);
            User user = userProvider.user.copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
            print("PRINTING CART");
            print(userProvider.user.cart);
            showSnackBar(context, 'Product added to cart');

          });
    }
     catch(e){
      print(e);
      showSnackBar(context, e.toString());
    }


  }
  Future<void> removeProductFromCart({required Product product, required BuildContext context})async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
     print("deleting");
      http.Response response =
      await http.delete(Uri.parse('$uri/api/user/remove-from-cart/${product.id}'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      print(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            // userProvider.cart.add(product);
            User user = userProvider.user.copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
            print("PRINTING CART");
            print(userProvider.user.cart);


          });
    }
    catch(e){
      print(e);
      showSnackBar(context, e.toString());
    }


  }

  Future<void> getCart({required Product product, required BuildContext context})async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{

      http.Response response =
      await http.get(Uri.parse('$uri/api/user/get-cart'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });
      print(response.body);
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
            print("PRINTING CART");
            print(userProvider.user.cart);

            // userProvider.user.cart = jsonDecode(response.body);
            //
            // print(userProvider.cart);
            return;
          });
    }
    catch(e){
      print(e);
      showSnackBar(context, e.toString());
    }


  }
}
