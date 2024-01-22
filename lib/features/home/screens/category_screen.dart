import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/account/widget/single_product_display.dart';
import 'package:amaclone/features/home/services/home_services.dart';
import 'package:amaclone/features/product_details/screens/product_details_screen.dart';
import 'package:amaclone/models/product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  static const routeName = "/category-screen";

  const CategoryScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Product>? productsByCategory;
  final _homeServices = HomeServices();

  Future<void> getProductsByCategory() async {
    productsByCategory = await _homeServices.fetchCategoryProducts(
        context: context, category: widget.category);

    setState(() {});
  }

  @override
  void initState() {
    getProductsByCategory();
    super.initState();
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
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
      body: productsByCategory == null
          ? const LoadingWidget()
          : Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            alignment: Alignment.topLeft,
            child: Text(
              "Keep shopping for ${widget.category}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child:
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: productsByCategory!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProductDetailScreen.routeName,
                        arguments: productsByCategory![index]);
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProductDisplay(
                            image: productsByCategory![index].images[0]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                                  productsByCategory![index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )),

                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            // GridView.builder(
            //     padding: const EdgeInsets.only(left: 15),
            //     scrollDirection: Axis.horizontal,
            //     itemCount: productsByCategory!.length,
            //     gridDelegate:
            //         const SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 1,
            //             childAspectRatio: 1.4,
            //             mainAxisSpacing: 10.0),
            //     itemBuilder: (_, index) {
            //       final product = productsByCategory![index];
            //       return Column(
            //         children: [
            //           SizedBox(
            //               height: 130,
            //               child: DecoratedBox(
            //                   decoration: BoxDecoration(
            //                       border: Border.all(
            //                           color: Colors.black12,
            //                           width: 0.5)),
            //                   child: Padding(
            //                     padding: const EdgeInsets.all(10.0),
            //                     child:
            //                         Image.network(product.images[0]),
            //                   ))),
            //           Container(
            //             alignment: Alignment.topLeft,
            //             padding: const EdgeInsets.only(left: 0,top: 5,right: 15),
            //             child: Text(
            //               product.name,maxLines: 1,overflow: TextOverflow.ellipsis,
            //             ),
            //           )
            //         ],
            //       );
            //     }),
          )
        ],
      ),
    );
  }
}
