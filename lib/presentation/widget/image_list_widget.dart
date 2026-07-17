import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'image_item_widget.dart';

class ImageListWidget extends StatelessWidget {
  final List<Identifier> imagesIdentifiers;

  const ImageListWidget({super.key, required this.imagesIdentifiers});

  @override
  Widget build(BuildContext context) {
    if (imagesIdentifiers.isEmpty) {
      return const Text("No image");
    }

    return Card(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(4),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: imagesIdentifiers.length,
        itemBuilder: (context, index) {
          return ImageItemWidget(imageIdentifier: imagesIdentifiers[index]);
        },
      ),
    );
  }
}
