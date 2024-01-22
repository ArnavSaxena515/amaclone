import 'package:amaclone/constants/global_variables.dart';
import 'package:amaclone/features/home/screens/category_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  const TopCategories({Key? key}) : super(key: key);

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  void navigateToCategoryScreen(String category) {
    Navigator.pushNamed(context, CategoryScreen.routeName,
        arguments:  category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          itemCount: GlobalVariables.categoryImages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  navigateToCategoryScreen(
                      GlobalVariables.categoryImages[index]['title']!);
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          GlobalVariables.categoryImages[index]['image']!,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                    Text(
                      GlobalVariables.categoryImages[index]['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
