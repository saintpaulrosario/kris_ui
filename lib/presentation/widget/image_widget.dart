import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kris/model/medium.dart';
import 'package:kris/presentation/widget/image_viewer_widget.dart';


class ImageWidget extends StatelessWidget {
  final Medium image;

  const ImageWidget({super.key, required this.image});

  Uint8List _decodeImage(String payload) {
    return Uint8List.fromList(base64Decode(payload));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        MaterialPageRoute(builder: (_) => ImageViewerWidget(image: image)),
      },
      child: Image.memory(
        _decodeImage(image.content),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image));
        },
      ),
    );
  }
}
