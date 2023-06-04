import 'package:flutter/material.dart';
import '../widget/UserGreeting.dart';
import '../widget/account_button.dart';
import '../widget/orders.dart';
import '../../../constants/global_variables.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

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
                      print('pressed');
                    }),
                AccountButton(
                    text: 'Turn Seller',
                    onTap: () {
                      print('pressed');
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
                      print('pressed');
                    }),
                AccountButton(
                    text: 'Your Wish List',
                    onTap: () {
                      print('pressed');
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
