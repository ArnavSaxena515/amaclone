// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amaclone/constants/error_handling.dart';
import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/constants/utils.dart';

import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common/widgets/navbar.dart';
import 'models/user.dart';
import "package:http/http.dart" as http;

class AuthService {
  // sign up the user

  void signUpUser(
      {required String email,
      required String password,
      required BuildContext context,
      required String name}) async {
    User user = User(
        id: "",
        name: name,
        password: password,
        address: "",
        token: "",
        email: email,
        type: "type");
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode(user.toJson()),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Account created successfully! Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse("$uri/api/login"),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences sharedPreferencesInstance =
                await SharedPreferences.getInstance();
            final responseBody = jsonDecode(response.body);
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonDecode(response.body));
            await sharedPreferencesInstance.setString(
                'x-auth-token', responseBody['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, Navbar.routeName, (route) => false);
          });
    } catch (e) {
      print(e);
    }
  }

  // authenticate and get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('x-auth-token');
      // if first time user, they won't have auth token
      if (token == null) {
        pref.setString('x-auth-token', "");
      }
      final tokenResponse = await http.post(
          Uri.parse("$uri/api/tokenValidation"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': token!
          });
      print(tokenResponse);

      if (jsonDecode(tokenResponse.body) == true) {
        // get user data
        final userResponse = await http.get(Uri.parse("$uri/"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              'x-auth-token': token
            });

        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(jsonDecode(userResponse.body));
      }
    } catch (e) {
      print(e);
    }
  }
}
