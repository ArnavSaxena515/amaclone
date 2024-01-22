import 'package:amaclone/common/widgets/rating_bar.dart';
import 'package:amaclone/features/product_details/screens/product_details_screen.dart';
import 'package:amaclone/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/loading_widget.dart';

class SearchResultProduct extends StatelessWidget {
  const SearchResultProduct({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    void navigateToProductDetails() {
      Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product);
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
                product.images[0],
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
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child:  DisplayRatingBar(
                      rating: product.rating??0,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
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
                      product.quantity > 0 ? 'In Stock' : "Out of Stock",
                      style: TextStyle(
                          fontSize: 16,
                          color:
                          product.quantity == 0 ? Colors.red : Colors.teal),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ]),
          )
        ],
      ),
    );
  }
}
