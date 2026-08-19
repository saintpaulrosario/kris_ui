import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kris/model/medium.dart';

class ImageViewerWidget extends StatelessWidget {
  final Medium image;

  const ImageViewerWidget({super.key, required this.image});

  Uint8List _decodeImage(String payload) {
    return Uint8List.fromList(base64Decode(payload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Row(
          children: [
            // IMAGE AREA
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Center(
                    child: Hero(
                      tag: image.tags,
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 5,
                        panEnabled: true,
                        child: Image.memory(
                          _decodeImage(image.content),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // DESCRIPTION AREA
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black87,
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: image.descriptions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        image.descriptions[index].sku,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
