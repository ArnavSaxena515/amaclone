import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/account/services/account_services.dart';
import 'package:amaclone/features/account/widget/single_product_display.dart';
import 'package:amaclone/features/order_details/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/loading_widget.dart';
import '../../../models/order.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders = [];

  late AccountServices accountServices;

  @override
  void initState() {
    accountServices = AccountServices(context: context);
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    final stuff = await accountServices.getOrders();
    setState(() {});
    if (stuff.isNotEmpty) {
      orders = [];
      for (int i = 0; i < stuff.length; i++) {
          orders?.add(stuff[i]);
      }

      setState(() {

      });
      return;
    } else {
      orders = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return orders==null ? const LoadingWidget() :  Column(
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
              itemCount: orders!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {

                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orders![index]);
                  },
                  child: SingleProductDisplay(
                    image: orders![index].products[0].images[0],
                  ),
                );
              })),
        ),
      ],
    );
  }
}
