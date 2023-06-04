import 'package:amaclone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final List<String> images;

  const CarouselImage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Builder(
                  builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(height: 200, viewportFraction: 1));
  }
}
