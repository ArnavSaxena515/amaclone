import 'dart:convert';

import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../../models/product.dart';

class SearchServices {
  Future<List<Product>> fetchSearchResults(
      {required BuildContext context, required String searchQuery}) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> products = [];
    try {

      http.Response response = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': user.token,
      });

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            final temp = jsonDecode(response.body);
            for (int i = 0; i < temp.length; i++) {
              products.add(Product.fromJson(temp[i]));
            }
          });
      return products;
    } catch (e) {
      showSnackBar(context, e.toString());

      return [];
    }
  }
}
