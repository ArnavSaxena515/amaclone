import 'package:amaclone/features/home/widgets/carousel_image.dart';
import 'package:amaclone/features/home/widgets/deal_of_day.dart';
import 'package:amaclone/features/home/widgets/home_app_bar.dart';
import 'package:amaclone/features/home/widgets/top_categories.dart';
import 'package:amaclone/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/address_box.dart';
import '../../../constants/global_variables.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void navigateToSearchScreen(String searchQuery) {
    Navigator.of(context)
        .pushNamed(SearchScreen.routeName, arguments: searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AppBar(
      //     flexibleSpace: Container(
      //       decoration: const BoxDecoration(
      //         gradient: GlobalVariables.appBarGradient,
      //       ),
      //     ),
      //     title: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Expanded(
      //           child: Container(
      //               height: 42,
      //               margin: const EdgeInsets.only(left: 15),
      //               child: Material(
      //                 borderRadius: BorderRadius.circular(7.0),
      //                 elevation: 1,
      //                 child: TextFormField(
      //                   onFieldSubmitted: (String searchQuery) {
      //                     navigateToSearchScreen(searchQuery);
      //                   },
      //                   textInputAction: TextInputAction.search,
      //                   controller: _searchQueryController,
      //                   decoration: InputDecoration(
      //                       filled: true,
      //                       //  icon: const Icon(Icons.search_outlined),
      //                       fillColor: Colors.white,
      //                       contentPadding: const EdgeInsets.only(top: 10),
      //                       border: const OutlineInputBorder(
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(7),
      //                         ),
      //                         borderSide: BorderSide.none,
      //                       ),
      //                       enabledBorder: const OutlineInputBorder(
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(7),
      //                         ),
      //                         borderSide:
      //                             BorderSide(color: Colors.black38, width: 1),
      //                       ),
      //                       hintText: 'Search Amaclone',
      //                       hintStyle: const TextStyle(
      //                           fontWeight: FontWeight.w500, fontSize: 17),
      //                       prefixIcon: InkWell(
      //                         onTap: () {
      //                           navigateToSearchScreen(
      //                               _searchQueryController.text);
      //                         },
      //                         child: const Padding(
      //                           padding: EdgeInsets.only(left: 6),
      //                           child: Icon(
      //                             Icons.search,
      //                             color: Colors.black,
      //                             size: 23,
      //                           ),
      //                         ),
      //                       )),
      //                 ),
      //               )),
      //         ),
      //         Container(
      //           color: Colors.transparent,
      //           height: 42,
      //           margin: const EdgeInsets.symmetric(horizontal: 10),
      //           child: const Icon(
      //             Icons.mic,
      //             color: Colors.black,
      //             size: 25,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            AddressBox(),
            SizedBox(height: 10),
            TopCategories(),
            SizedBox(height: 10),
            CarouselImage(images: GlobalVariables.carouselImages),
           DealOfDay(),
          ],
        ),
      ),
    );
  }
}
