import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/search/widgets/search_result_product.dart';
import 'package:amaclone/features/home/widgets/address_box.dart';
import 'package:amaclone/features/home/widgets/home_app_bar.dart';
import 'package:amaclone/features/search/services/search_services.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search-screen";

  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? searchResults;
  final searchServices = SearchServices();

  Future<void> searchProducts() async {
    print("Searching");
    searchResults = await searchServices.fetchSearchResults(
        context: context, searchQuery: widget.searchQuery);
    setState(() {

    });
    print(searchResults);

  }
  @override
  void initState() {
     searchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body:searchResults==null?const LoadingWidget() :  Column(
        children: [const AddressBox(),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults!.length,
                itemBuilder: (_, index) => SearchResultProduct(product: searchResults![index])),
          ),
        ],
      ),
    );
  }
}
