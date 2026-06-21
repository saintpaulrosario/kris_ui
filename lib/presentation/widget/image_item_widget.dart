import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import '../../model/image.dart' as WordImage;

class ImageItemWidget extends StatelessWidget {
  final WordImage.Image image;

  const ImageItemWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    // Assuming sound.data is Base64 String
    Uint8List imageBytes = Uint8List.fromList(base64Decode(image.payload));

    return Expanded(
      child: Image.memory(
        imageBytes,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
