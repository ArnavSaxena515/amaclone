import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarouselImage extends StatelessWidget {
  final List<XFile> images;

  const CarouselImage({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: images
            .map((e) => Builder(
                  builder: (BuildContext context) => Image.file(
                    File(e.path),
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(height: 200, viewportFraction: 1));
  }
}
