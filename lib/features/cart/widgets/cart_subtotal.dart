import 'package:flutter/material.dart';

class CartSubtotal extends StatelessWidget {
  final String sum;
  const CartSubtotal({Key? key, required this.sum}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          RichText(
            text:  TextSpan(
                text: 'Subtotal, ',
                style: const TextStyle(color: Colors.black, fontSize: 20),
                children: [
                  TextSpan(
                      text: "\$$sum",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))
                ]),
          ),
        ],

      ),
    );
  }
}
