import 'dart:convert';

import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/constants/secrets.dart';
import 'package:amaclone/features/admin/models/sales.dart';
import 'package:amaclone/models/order.dart';
import 'package:amaclone/models/user.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amaclone/models/product.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';

class AdminServices {
  late User user;
  final BuildContext context;

  AdminServices({required this.context}) {
    user = Provider.of<UserProvider>(context, listen: false).user;
  }

  void sellProduct(
      {required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<XFile> images}) async {
    try {
      final cloudinary =
          CloudinaryPublic(cloudinaryCloudName, cloudinaryUploadPreset);

      List<String> imageURLs = [];
      for (int i = 0; i < images.length; i++) {
        //final assetId = jsonDecode(response.body)['_id'];
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path,
              //   publicId: assetId,
              folder: name,
              resourceType: CloudinaryResourceType.Image),
        );
        imageURLs.add(res.secureUrl);

      }

      Product product = Product(
        name: name,
        description: description,
        category: category,
        quantity: quantity,
        price: price,
        sellerId: user.id,
        images: [...imageURLs],
      );


      http.Response response = await http.post(
          Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': user.token
          },
          body: jsonEncode(product));



      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {

      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': user.token,
        "sellerId": user.id
      });


      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            final temp = jsonDecode(response.body);
            for (int i = 0; i < temp['products'].length; i++) {
              products.add(Product.fromJson(temp['products'][i]));
            }

          });

      return products;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      http.Response response =
          await http.delete(Uri.parse('$uri/admin/delete-product'),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                'x-auth-token': user.token,
                "sellerId": user.id
              },
              body: jsonEncode({'productId': productId}));
      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product deleted");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> getAllOrders() async {
    List<Order> orders = [];
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/admin/get-all-orders'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': user.token,
            //"sellerId": user.id
          });

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            final temp = jsonDecode(response.body)['orders'];
            for (int i = 0; i < temp.length; i++) {
              orders.add(Order.fromJson(temp[i]));
            }
          });

      return orders;
    } catch (e) {
      showSnackBar(context, e.toString());
      return [];
    }
  }

  Future<List<Order>> changeOrderStatus(
      {required int status,
      required Order order,
      required VoidCallback onSuccess}) async {
    List<Order> orders = [];
    try {
      final body = jsonEncode({'id': order.id, 'status': status});
      http.Response response =
          await http.post(Uri.parse('$uri/admin/change-order-status'),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                'x-auth-token': user.token,
                //"sellerId": user.id
              },
              body: body);

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response, context: context, onSuccess: onSuccess);

      return orders;
    } catch (e) {
      showSnackBar(context, e.toString());

      return [];
    }
  }

  Future<Map<String, dynamic>> getEarnings() async {
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/admin/analytics'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        'x-auth-token': user.token,
        //"sellerId": user.id
      });

      // ignore: use_build_context_synchronously
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            var temp = jsonDecode(response.body);

            totalEarning = temp['totalEarnings'];
            sales = [
              Sales('Mobiles', temp['mobileEarnings']),
              Sales('Essentials', temp['essentialsEarnings']),
              Sales('Appliances', temp['appliancesEarnings']),
              Sales('Books', temp['booksEarnings']),
              Sales('Fashion', temp['fashionEarnings']),
            ];
          });

      return {
        'sales':sales,
        'totalEarnings':totalEarning
      };
    } catch (e) {
      showSnackBar(context, e.toString());

      return {};
    }
  }
}
