import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<String> pickImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image!.path;
}

Future<String> pickImageFromCamera() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image!.path;
}

Future<List<XFile>> pickMultipleImages() async {

  try {
    final ImagePicker picker = ImagePicker();
     List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      return images;
    }
    return images;
  } catch (e) {
    throw e.toString();
  }
}


