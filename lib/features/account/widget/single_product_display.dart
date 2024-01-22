import 'package:amaclone/constants/loading_widget.dart';
import 'package:flutter/material.dart';

class SingleProductDisplay extends StatelessWidget {
  const SingleProductDisplay({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            image,
            fit: BoxFit.fitHeight, width: 180,

            loadingBuilder: (BuildContext context,Widget child, ImageChunkEvent? loadingProgress ){
              if(loadingProgress == null) return child;
              return Center(
                child:LoadingWidget(
                  value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
                      : null
              ));
            },

          ),
        ),
      ),
    );
  }
}
