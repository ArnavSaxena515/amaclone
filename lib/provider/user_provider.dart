import 'package:amaclone/models/user.dart';
import 'package:flutter/material.dart';


class UserProvider extends ChangeNotifier{
  User _user = User(id: "", name: "", password: "", email: "", address: "", token: "", type: "", cart: []);

  User get user =>_user;

  void setUser(Map<String, dynamic> user){
    _user = User.fromJson(user);
    notifyListeners();
  }
  void setUserFromModel(User user){
    _user = user;
    notifyListeners();
  }
}
