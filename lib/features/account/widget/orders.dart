import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/account/widget/product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List temporaryItems = [
    'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    // 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
    'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
    'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
    'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
    'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 15.0),
                child: const Text(
                  'Your Orders',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )),
            Container(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  'See all',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: GlobalVariables.selectedNavBarColor),
                )),
          ],
        ),
        Container(
          height: 180,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
              itemCount: temporaryItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Product(
                  image: temporaryItems[index],
                );
              })),
        ),
      ],
    );
  }
}
