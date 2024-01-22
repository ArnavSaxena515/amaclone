import 'package:amaclone/common/widgets/custom_button.dart';
import 'package:amaclone/common/widgets/rating_bar.dart';
import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/admin/widgets/carousel_images.dart';
import 'package:amaclone/features/home/widgets/home_app_bar.dart';
import 'package:amaclone/features/product_details/services/product_details_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../models/product.dart';

class ProductDetailScreen extends StatefulWidget {
  static const String routeName = '/product-detail-screen';

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  void addToCart()async{
    await ProductDetailsService().addProductToCart(product: widget.product, context: context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.product.id!),
                    DisplayRatingBar(rating: widget.product.rating??0)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Text(
                widget.product.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CarouselImage.fromNetwork(urls: widget.product.images, height: 300),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                    text: "Deal Price:\t\t",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: "\$${widget.product.price}",
                          style: const TextStyle(
                              fontSize: 22,
                              color: Colors.red,
                              fontWeight: FontWeight.w500))
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.product.description),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(text: 'Buy Now', onPressed: () {}),
            ),
            addSpacing(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                text: 'Add to Cart',
                onPressed: () {
                  addToCart();
                },
                color: const Color.fromRGBO(254, 216, 19, 1),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            addSpacing(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Rate the product',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
              itemCount: 5,
              initialRating: 0,
                minRating: 1,
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              direction: Axis.horizontal,
              itemBuilder: (ctx, _) => const Icon(
                Icons.star,
                color: GlobalVariables.secondaryColor,
              ), onRatingUpdate: (double value) {
                ProductDetailsService().rateProduct(context: context, product: widget.product,rating: value);
            },
            ),
          ],
        ),
      ),
    );
  }
}

SizedBox addSpacing() {
  return const SizedBox(
    height: 10,
  );
}
