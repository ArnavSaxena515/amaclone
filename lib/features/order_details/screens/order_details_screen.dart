import 'package:amaclone/common/widgets/custom_button.dart';
import 'package:amaclone/features/admin/services/admin_services.dart';
import 'package:amaclone/features/home/widgets/home_app_bar.dart';
import 'package:amaclone/models/order.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailScreen extends StatefulWidget {
  final Order order;
  static const String routeName = '/order-details';

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentStep = 0;

  @override
  void initState() {
    currentStep = widget.order.status!;
    adminServices = AdminServices(context: context);
    super.initState();
  }

  // for admin
  late AdminServices adminServices;

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(status: status+1, order: widget.order, onSuccess: (){
      setState(() {
        currentStep +=1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider
        .of<UserProvider>(context, listen: false)
        .user;
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Order Date:"),
                        Text(DateFormat().format(
                            DateTime.fromMillisecondsSinceEpoch(
                                widget.order.orderedAt)))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Order ID:"),
                        Text(widget.order.id),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Price:'),
                        Text("\$${widget.order.totalPrice}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Purchase Details",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < widget.order.products.length; i++)
                            Row(
                              children: [
                                Image.network(
                                  widget.order.products[i].images[0],
                                  height: 120,
                                  width: 120,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.order.products[i].name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "Quantity: x ${widget.order
                                              .quantity[i].toString()}",
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tracking",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Stepper(
                        currentStep: currentStep,
                        controlsBuilder: (context, details) {
                          if (user.type == 'admin') {
                            return CustomButton(text: 'Done', onPressed: ()=>changeOrderStatus(details.currentStep));
                          }
                          return const SizedBox();
                        },
                        steps: [
                          Step(
                              state: currentStep > 0
                                  ? StepState.complete
                                  : StepState.indexed,
                              isActive: currentStep > 0,
                              title: const Text('Pending'),
                              content:
                              const Text('Your order is yet to be delivered')),
                          Step(state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,

                              isActive: currentStep > 1,
                              title: const Text('Completed'),
                              content:
                              const Text(
                                  'Your order has been delivered, pending signature of recipient')),
                          Step(
                              state: currentStep > 2
                                  ? StepState.complete
                                  : StepState.indexed,

                              isActive: currentStep > 2,
                              title: const Text('Received'),
                              content:
                              const Text(
                                  'Your order has been delivered and signed')),

                          Step(
                              state: currentStep >= 3
                                  ? StepState.complete
                                  : StepState.indexed,

                              isActive: currentStep >= 3,
                              title: const Text('Delivered'),
                              content:
                              const Text('Your order is yet to be delivered')),

                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
