import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/identifier.dart';
import 'image_item_widget.dart';

class ImageListWidget extends StatelessWidget {
  final List<Identifier> imagesIdentifiers;

  const ImageListWidget({super.key, required this.imagesIdentifiers});

  @override
  Widget build(BuildContext context) {
    if (imagesIdentifiers.isEmpty) {
      return Text("no image");
    }

    return Card(
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: imagesIdentifiers.length,
        itemBuilder: (context, index) {
          return ImageItemWidget(imageIdentifier: imagesIdentifiers[index]);
        },
      ),
    );
  }
}
