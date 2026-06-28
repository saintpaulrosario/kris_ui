import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/word_image.dart';

class ImageItemWidget extends StatefulWidget {
  final Identifier imageIdentifier;

  const ImageItemWidget({super.key, required this.imageIdentifier});

  @override
  State<ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  void initState() {
    super.initState();

    context.read<ImageBloc>().add(
      RetrieveImagesBySkuEvent(sku: widget.imageIdentifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ImageBloc, ImageState, bool>(
      selector: (state) {
        return state.fetching.contains(widget.imageIdentifier.sku);
      },
      builder: (context, state) {
        if (state) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              height: 300,
              color: Colors.white,
            ),
          );
        }

        return BlocSelector<ImageBloc, ImageState, Map<String, WordImage>>(
          selector: (state) {
            return state.images;
          },
          builder: (context, state) {
            if (state.isEmpty ||
                !state.containsKey(widget.imageIdentifier.sku)) {
              return const Center(
                child: Icon(Icons.broken_image, size: 44, color: Colors.grey),
              );
            } else {
              return BlocSelector<ImageBloc, ImageState, WordImage>(
                selector: (state) {
                  return state.images[widget.imageIdentifier.sku]!;
                },
                builder: (context, state) {
                  final Uint8List imageBytes = Uint8List.fromList(
                    base64Decode(state.payload),
                  );
                  return InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5.0,
                    panEnabled: true,
                    child: Image.memory(imageBytes, fit: BoxFit.contain),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
