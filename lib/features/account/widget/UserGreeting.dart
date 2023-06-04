import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserGreeting extends StatelessWidget {
  const UserGreeting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: 'Hello, ',
                style: const TextStyle(color: Colors.black, fontSize: 22),
                children: [
                  TextSpan(
                      text: _user.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
