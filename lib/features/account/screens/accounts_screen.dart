import 'dart:math';

import 'package:amaclone/features/account/services/account_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widget/UserGreeting.dart';
import '../widget/account_button.dart';
import '../widget/orders.dart';
import '../../../constants/global_variables.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountServices accountServices;
  @override
  void initState() {
    accountServices = AccountServices(context: context);
    logout();
    super.initState();
  }
  void logout()async{
    accountServices.logOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    height: 50,
                    width: 120,
                    color: Colors.black,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: const [
                    Icon(Icons.notifications_outlined),
                    SizedBox(width: 12),
                    Icon(Icons.search)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const UserGreeting(),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccountButton(
                    text: 'Your Orders',
                    onTap: () {
                      if (kDebugMode) {
                        print('pressed');
                      }
                    }),
                AccountButton(
                    text: 'Turn Seller',
                    onTap: () {
                      if (kDebugMode) {
                        print('pressed');
                      }
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AccountButton(
                    text: 'Log out',
                    onTap: () {

                      logout();
                    }),
                AccountButton(
                    text: 'Your Wish List',
                    onTap: () {
                      if (kDebugMode) {
                        print('pressed');
                      }
                    }),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Orders(),
        ],
      ),
    );
  }
}
