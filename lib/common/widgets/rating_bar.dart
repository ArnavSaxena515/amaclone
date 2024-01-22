import 'package:amaclone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class DisplayRatingBar extends StatelessWidget {
  const DisplayRatingBar({Key? key, required this.rating}) : super(key: key);
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(rating:rating,direction: Axis.horizontal,itemCount:5, itemSize:15,itemBuilder: (context,_)=>const Icon(Icons.star, color: GlobalVariables.secondaryColor,));
  }
}
