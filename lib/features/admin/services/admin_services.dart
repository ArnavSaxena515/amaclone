import 'dart:convert';

import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/constants/secrets.dart';
import 'package:amaclone/models/user.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:amaclone/models/product.dart';
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
      print(imageURLs);
      Product product = Product(
        name: name,
        description: description,
        category: category,
        quantity: quantity,
        price: price,
        sellerId: user.id,
        imageUrls: [...imageURLs],
      );
      print(product.imageUrls);

      http.Response response = await http.post(
          Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': user.token
          },
          body: jsonEncode(product));

      print(response.body);

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      print(e.toString());
      showSnackBar(context, e.toString());
    }
  }

  void getProducts() async {
    try {
      print(user.id);
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': user.token,
          "sellerId": user.id
        }
      );
      print(response.body);

      final cloudinary =
          CloudinaryPublic(cloudinaryCloudName, cloudinaryUploadPreset);
      final products = (jsonDecode(response.body)['products']);
      String url = '';
      for (int i = 0; i < products.length; i++) {
        print( "stuff");
        url =
            'https://api.cloudinary.com/v1_1/$cloudinaryCloudName/${products[i]["_id"]}';
        print(cloudinary.getImage(products[i]["_id"]));
        print(cloudinary.getImage(products[i]["_id"]).url);
        print(cloudinary.getImage(products[i]["_id"]).publicId);
        CloudinaryImage img = cloudinary.getImage(products[i]["_id"]);

        // print(url);
        // http.Response res = await http.get(Uri.parse(url));
        // print(res.statusCode);
        // print(res.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
