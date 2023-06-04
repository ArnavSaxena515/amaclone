import 'package:amaclone/constants/global_variables.dart';
import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void navigateToAddProductScreen(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Post(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a Product',
        onPressed: navigateToAddProductScreen,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}

class Post extends StatelessWidget {
  const Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 1.5),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Container(
                width: 180,
                padding: const EdgeInsets.all(10),
                child: Image.network(
                  GlobalVariables.dummyImages[1],
                  fit: BoxFit.fitHeight,
                  width: 180,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('iPhone'),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.delete_outline))
            ],
          )
        ],
      ),
    );
  }
}
