import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/account/widget/single_product_display.dart';
import 'package:amaclone/models/product.dart';
import 'package:flutter/material.dart';

import '../services/admin_services.dart';
import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  late AdminServices _adminServices;
  List<Product>? products;

  @override
  void initState() {
    _adminServices = AdminServices(context: context);
    getProducts();
    super.initState();
  }

  void navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductScreen.routeName)
        .then((value) => getProducts());
  }

  void getProducts() async {
  //  if (products != null) products = [];
    final stuff = await _adminServices.getProducts();
    setState(() {});
    if (stuff.isNotEmpty) {
      products = [];
      for (int i = 0; i < stuff.length; i++) {
        setState(() {
          products?.add(stuff[i]);
        });
      }
      return;
    } else {
      products = [];
    }
  }

  void deleteProduct(String? productId, int index) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Delete Listing",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Are you sure you want to delete product '${products![index].name}'?",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () async {
                              await _adminServices.deleteProduct(productId!);
                              setState(() {
                                products!.removeAt(index);
                                Navigator.of(context).pop();
                              });
                              return;
                            },
                            child: const Text("Yes")),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"))
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
    // await _adminServices.deleteProduct(productId!);
    // setState(() {
    //   products!.removeAt(index);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const LoadingWidget()
        : Scaffold(
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: products?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProductDisplay(
                          image: products![index].images[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            products![index].name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )),
                          IconButton(
                              onPressed: () {
                                deleteProduct(products![index].id, index);
                              },
                              icon: const Icon(Icons.delete_outline))
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              tooltip: 'Add a Product',
              onPressed: navigateToAddProductScreen,
              child: const Icon(Icons.add_outlined),
            ),
          );
  }
}
