import 'package:amaclone/common/widgets/custom_button.dart';
import 'package:amaclone/constants/loading_widget.dart';
import 'package:amaclone/constants/utils.dart';
import 'package:amaclone/features/address/services/address_services.dart';
import 'package:amaclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;

  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();
  final _addressFlatController = TextEditingController();
  final _addressStreetController = TextEditingController();
  final _addressPincodeController = TextEditingController();
  final _addressCityController = TextEditingController();

  @override
  void dispose() {
    _addressCityController.dispose();
    _addressPincodeController.dispose();
    _addressFlatController.dispose();
    _addressStreetController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount to pay',
        status: PaymentItemStatus.final_price));
    super.initState();
  }

  String address = '';

  void payPressed(String address) {
    address = "";
    var addressFromProvider =
        Provider.of<UserProvider>(context, listen: false).user.address;

    bool isFormUsed = _addressStreetController.text.isNotEmpty ||
        _addressFlatController.text.isNotEmpty ||
        _addressPincodeController.text.isNotEmpty ||
        _addressCityController.text.isNotEmpty;

    if (isFormUsed) {
      if (_addressFormKey.currentState!.validate()) {
        address =
            "${_addressFlatController.text}, ${_addressStreetController.text}, ${_addressCityController.text} - ${_addressPincodeController.text}";
      AddressServices(context: context).saveUserAddress(address: address);
      } else {
        throw Exception("Please enter all the values for address");
      }
    } else if (addressFromProvider.isNotEmpty) {
      address = addressFromProvider;
    } else {
      showSnackBar(context, "Error: No address found");
    }
  }

  List<PaymentItem> paymentItems = [];

  @override
  Widget build(BuildContext context) {
    final addressServices = AddressServices(context: context);
    //var address = context.watch<UserProvider>().user.address;
    var address = Provider.of<UserProvider>(context, listen:false).user.address;

    void onGooglePayResult(result) {
      if (Provider.of<UserProvider>(context,listen: false).user.address.isEmpty) {
        addressServices.saveUserAddress(address: address);
      }
      print("Placing order");
      addressServices.placeOrder(
          address: address, totalSum: double.parse(widget.totalAmount));
    }

    void onApplePayResult(result) {
      if (Provider.of<UserProvider>(context, listen: false).user.address.isEmpty) {
        addressServices.saveUserAddress(address: address);
      }
      addressServices.placeOrder(
          address: address, totalSum: double.parse(widget.totalAmount));
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            address,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('OR', style: TextStyle(fontSize: 18)),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _addressFlatController,
                      hintText: "Flat, House number, Building",
                    ),
                    CustomTextField(
                      controller: _addressStreetController,
                      hintText: "Area, Street",
                    ),
                    CustomTextField(
                      controller: _addressPincodeController,
                      hintText: "Pincode",
                    ),
                    CustomTextField(
                      controller: _addressCityController,
                      hintText: "Town, City",
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              GooglePayButton(
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  width: double.infinity,
                  type: GooglePayButtonType.buy,
                  onPaymentResult: onGooglePayResult,
                  loadingIndicator: const LoadingWidget(),
                  onPressed: () {
                    payPressed(address);
                  },
                  paymentConfigurationAsset: 'gpay.json',
                  paymentItems: paymentItems),
              CustomButton(text: 'Test Pay', onPressed: (){
                onGooglePayResult('');
              })

              // ApplePayButton(
              //   width: double.infinity,
              //   style: ApplePayButtonStyle.whiteOutline,
              //   type: ApplePayButtonType.buy,
              //   onPaymentResult: onApplePayResult,
              //   paymentItems: paymentItems,
              //   paymentConfigurationAsset: 'applepay.json',
              // )
            ],
          ),
        ),
      ),
    );
  }
}
