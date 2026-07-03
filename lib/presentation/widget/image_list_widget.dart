import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/identifier.dart';
import 'image_item_widget.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> imagesIdentifiers;

  const ImageListWidget({super.key, required this.imagesIdentifiers});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.imagesIdentifiers.isEmpty) {
      return const Text('No images available');
    }

    return Column(
      children: [
        ImageItemWidget(imageIdentifier: widget.imagesIdentifiers.first),
        if (widget.imagesIdentifiers.length > 1)
          ImageItemWidget(imageIdentifier: widget.imagesIdentifiers.last),
      ],
    );
  }
}
