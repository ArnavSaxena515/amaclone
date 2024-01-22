import 'package:amaclone/constants/loading_widget.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/utils.dart';
import '../services/admin_services.dart';
import '../widgets/carousel_images.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product-screen';

  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _addProductFormKey = GlobalKey<FormState>();

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _productDescription = TextEditingController();
  final TextEditingController _productPrice = TextEditingController();
  final TextEditingController _productQuantity = TextEditingController();

  final FocusNode _nameNode = FocusNode();
  final FocusNode _descriptionNode = FocusNode();
  final FocusNode _priceNode = FocusNode();
  final FocusNode _quantityNode = FocusNode();
   late AdminServices _adminServices;
  @override
  void initState() {
    // TODO: implement initState
    _adminServices = AdminServices(context: context);

    super.initState();
  }

   bool _isLoading = false;

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  String selectedCategory = 'Mobiles';
  List<XFile> images = [];

  void selectImages() async {
    final result = await pickMultipleImages();
    setState(() => images = result);
  }

  void postProduct() async {
    setState(() {
      _isLoading =true;
    });
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      _adminServices.sellProduct(


          name: _productName.text,
          description: _productDescription.text,
          price: double.parse(_productPrice.text),
          quantity: double.parse(_productQuantity.text),
          category: selectedCategory,
          images: images);
    }
    setState(() {
      _isLoading =false;
    });
  }



  @override
  void dispose() {
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    _productQuantity.dispose();

    _nameNode.dispose();
    _descriptionNode.dispose();
    _priceNode.dispose();
    _quantityNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void focusDescription(String? val) {
      FocusScope.of(context).requestFocus(_descriptionNode);
    }

    void focusPrice(String? val) {
      FocusScope.of(context).requestFocus(_priceNode);
    }

    void focusQuantity(String? val) {
      FocusScope.of(context).requestFocus(_quantityNode);
    }

    return _isLoading? const LoadingWidget() :Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Center(
                child: Text(
              'Add Product',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: selectImages,
                  child: images.isEmpty
                      ? DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          strokeWidth: 1,
                          radius: const Radius.circular(15),
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400),
                                ),
                              ],
                            ),
                          ),
                        )
                      : CarouselImage.fromFile(images: images),
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _productName,
                  hintText: 'Product Name',
                  focusNode: _nameNode,
                  onFieldSubmitted: focusDescription,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _productDescription,
                  hintText: 'Product Description',
                  maxLines: 7,
                  focusNode: _descriptionNode,
                  onFieldSubmitted: focusPrice,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _productPrice,
                  hintText: 'Price',
                  focusNode: _priceNode,
                  onFieldSubmitted: focusQuantity,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  controller: _productQuantity,
                  hintText: 'Quantity',
                  focusNode: _quantityNode,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories
                        .map((String category) => DropdownMenuItem(
                            value: category, child: Text(category)))
                        .toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        selectedCategory = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                    text: 'Post Product',
                    onPressed: () {
                      postProduct();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
