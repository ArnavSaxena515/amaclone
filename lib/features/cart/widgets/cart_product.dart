import 'package:amaclone/features/product_details/services/product_details_service.dart';
import 'package:amaclone/models/product.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/loading_widget.dart';
import '../../product_details/screens/product_details_screen.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

 void increaseQuantity(Product product){
   final detailsService = ProductDetailsService();
   detailsService.addProductToCart(product: product, context: context);

 }

 void decreaseQuantity(Product product){
   final detailsService = ProductDetailsService();
   detailsService.removeProductFromCart(product: product, context: context);

 }
  @override
  Widget build(BuildContext context) {
    final cartItem = context.watch<UserProvider>().user.cart[widget.index];
    final productInCart = Product.fromJson(cartItem['product']);
    final quantity = cartItem['quantity'];
    void navigateToProductDetails() {
      Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: productInCart);
    }
    return InkWell(
      onTap: () {
        navigateToProductDetails();
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Row(children: [
              Image.network(
                productInCart.images[0],
                fit: BoxFit.fitHeight,
                height: 135,
                width: 135,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                      child: LoadingWidget(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null));
                },
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      productInCart.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),

                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${productInCart.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'Eligible for FREE shipping',
                      style: TextStyle(fontSize: 16,),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      productInCart.quantity > 0 ? 'In Stock' : "Out of Stock",
                      style: TextStyle(
                          fontSize: 16,
                          color:
                          productInCart.quantity == 0 ? Colors.red : Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ]),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.black12, width: 1.5),borderRadius: BorderRadius.circular(5),color: Colors.black12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap:(){
                          increaseQuantity(productInCart);
                        },
                        child: Container(
                          width: 35, height: 32,
                          alignment: Alignment.center,
                          child: const Icon(Icons.add,size: 18,),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1.5),color: Colors.white
                       ,borderRadius: BorderRadius.circular(0) ),
                        
                        width: 35, height: 32,
                        alignment: Alignment.center,
                        child:  Text(quantity.toString()),
                      ),
                      InkWell(
                        onTap:(){
                          decreaseQuantity(productInCart);
                        },
                        child: Container(
                          width: 35, height: 32,
                          alignment: Alignment.center,
                          child: const Icon(Icons.remove,size: 18,),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
