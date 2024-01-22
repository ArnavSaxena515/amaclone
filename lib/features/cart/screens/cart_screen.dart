import 'package:amaclone/common/widgets/custom_button.dart';
import 'package:amaclone/features/address/screens/address_screen.dart';
import 'package:amaclone/features/cart/widgets/cart_product.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/cart_subtotal.dart';
import 'package:amaclone/features/home/widgets/address_box.dart';
import 'package:flutter/material.dart';

import '../../home/widgets/home_app_bar.dart';
import '../../search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
 // final _searchQueryController = TextEditingController();


  void navigateToSearchScreen(String searchQuery) {
    Navigator.of(context)
        .pushNamed(SearchScreen.routeName, arguments: searchQuery);
  }
  void navigateToAddressScreen(sum) {
    Navigator.of(context)
        .pushNamed(AddressScreen.routeName,arguments: sum);
  }
  @override
  Widget build(BuildContext context) {

    final user = context.watch<UserProvider>().user;
    double sum = 0;
    user.cart.map((e) => sum+=e['quantity']*e['product']['price'] as int).toList();
    return Scaffold(

      appBar: homeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children:  [
            const AddressBox(),
             CartSubtotal(sum: sum.toString(),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'Proceed to Buy ${user.cart.length} items ', onPressed: (){
                navigateToAddressScreen(sum);
              },color: Colors.yellow[600],),
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 15),
            ListView.builder(shrinkWrap:true,itemCount:user.cart.length ,itemBuilder: (context, index){return CartProduct(index: index);})
          ],
        ),
      ),
    );
  }
}
