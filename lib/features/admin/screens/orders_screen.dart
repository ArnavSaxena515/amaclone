import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/account/widget/single_product_display.dart';
import 'package:amaclone/features/admin/services/admin_services.dart';
import 'package:amaclone/features/order_details/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  late AdminServices adminServices;

  @override
  void initState() {
    adminServices = AdminServices(context: context);
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    print("fetching orders in screen");
    orders = await adminServices.getAllOrders();
    print(orders);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders==null? const LoadingWidget() : GridView.builder(
        itemCount: orders!.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context,index){
          final orderData = orders![index];
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: orderData);
            },
            child: SizedBox(
              height: 140, child: SingleProductDisplay(image: orderData.products[0].images[0]),
            ),
          );
        });
  }
}
