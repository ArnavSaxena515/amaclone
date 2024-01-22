import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../search/screens/search_screen.dart';
final _searchQueryController = TextEditingController();



 PreferredSize homeAppBar(context) {
   void navigateToSearchScreen(String searchQuery) {
     Navigator.of(context)
         .pushNamed(SearchScreen.routeName, arguments: searchQuery);
   }
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
                height: 42,
                margin: const EdgeInsets.only(left: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7.0),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: (String searchQuery) {
                      navigateToSearchScreen(searchQuery);
                    },
                    textInputAction: TextInputAction.search,
                    controller: _searchQueryController,
                    decoration: InputDecoration(
                        filled: true,
                        //  icon: const Icon(Icons.search_outlined),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search Amaclone',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                        prefixIcon: InkWell(
                          onTap: () {
                            navigateToSearchScreen(_searchQueryController.text);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        )),
                  ),
                )),
          ),
          Container(
            color: Colors.transparent,
            height: 42,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Icon(
              Icons.mic,
              color: Colors.black,
              size: 25,
            ),
          )
        ],
      ),
    ),
  );
}