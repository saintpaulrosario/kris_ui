import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/identifier.dart';
import 'image_item_widget.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identifier> images;

  const ImageListWidget({super.key, required this.images});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const Text('No images available');
    }
    final image = widget.images.first;
    return ImageItemWidget(image: image);
  }
}
