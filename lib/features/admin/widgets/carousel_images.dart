import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// class CarouselImage extends StatelessWidget {
//   final List<XFile> images;
//
//   const CarouselImage({Key? key, required this.images}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//         items: images
//             .map((e) => Builder(
//                   builder: (BuildContext context) => Image.file(
//                     File(e.path),
//                     fit: BoxFit.cover,
//                   ),
//                 ))
//             .toList(),
//         options: CarouselOptions(height: 200, viewportFraction: 1));
//   }
// }

class CarouselImage {
  static CarouselSlider fromFile({required List<XFile> images, double height=200}) {
    return CarouselSlider(
        items: images
            .map((e) => Builder(
                  builder: (BuildContext context) => Image.file(
                    File(e.path),
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(height: height, viewportFraction: 1));
  }

  static CarouselSlider fromNetwork({required List<String> urls, double height=200}) {
    return CarouselSlider(
        items: urls
            .map((e) => Builder(
                  builder: (BuildContext context) => Image.network(
                    e,
                    fit: BoxFit.cover,
                  ),
                ))
            .toList(),
        options: CarouselOptions(height: height, viewportFraction: 1));
  }
}
