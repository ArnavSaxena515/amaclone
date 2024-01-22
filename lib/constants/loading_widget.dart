import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? value;
  const LoadingWidget({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        value: value,
      ),
    );
  }
}
