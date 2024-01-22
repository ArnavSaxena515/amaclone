import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/features/home/services/home_services.dart';
import 'package:amaclone/features/product_details/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  late Product? product;
  bool loading = false;
  @override
  void initState() {
    getDealOfTheDay();
    super.initState();
  }
  void getDealOfTheDay() async{
    setState(() {
      loading=true;
    });
    final homeServices = HomeServices();
    product = await homeServices.fetchDealOfTheDay(context: context);
    setState(() {
      loading=false;
    });
    
  }
  void navigateToProductScreen( product){
    //todo add hero animation
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }
  @override
  Widget build(BuildContext context) {
    return loading? const LoadingWidget():product !=null?InkWell(
      onTap: (){
        navigateToProductScreen(product);
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 10, top: 15),
            child: const Text(
              'Deal of the day',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Image.network(
            product!.images[0],
            height: 235,
            fit: BoxFit.fitHeight,
          ),
          Container(
            padding: const EdgeInsets.only(left: 15),
            alignment: Alignment.topLeft,
            child: Text(
              '\$${product!.price}',
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
            child:  Text(
              "${product!.name} on sale!",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // SizedBox(height: 200,
          //   child: ListView.builder(itemCount: product!.images.length,scrollDirection: Axis.horizontal,itemBuilder: (BuildContext ctx, index){
          //     return Container(margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 10),child: Image.network(product!.images[index],fit: BoxFit.fitWidth,width: 100,));
          //   }),
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //       Image.network(
          //           'https://codelabs.developers.google.com/static/codelabs/flutter-flame-game/img/afb0fd6677c2a621.png',
          //           fit: BoxFit.fitWidth,
          //           width: 100),
          //     ],
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
            alignment: Alignment.topLeft,
            child: Text(
              'See all deals',
              style: TextStyle(color: Colors.cyan[800]),
            ),
          )
        ],
      ),
    ):const SizedBox();
  }
}
