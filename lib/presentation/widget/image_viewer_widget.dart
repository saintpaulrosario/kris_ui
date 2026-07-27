import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kris/logic/identifier.dart';

class ImageViewerWidget extends StatelessWidget {
  final Identifier identifier;
  final String payload;
  final List<String> descriptions;

  const ImageViewerWidget({
    super.key,
    required this.identifier,
    required this.payload,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    final imageBytes = Uint8List.fromList(base64Decode(payload));

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
                      tag: identifier.sku,
                      child: InteractiveViewer(
                        minScale: 1,
                        maxScale: 5,
                        panEnabled: true,
                        child: Image.memory(imageBytes, fit: BoxFit.contain),
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
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        descriptions[index],
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
