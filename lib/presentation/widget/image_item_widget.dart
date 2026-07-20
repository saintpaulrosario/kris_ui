import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/identifier.dart';
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

    _retrieveImage();
  }

  @override
  void didUpdateWidget(covariant ImageItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imageIdentifier.sku != widget.imageIdentifier.sku) {
      _retrieveImage();
    }
  }

  void _retrieveImage() {
    final exists = context.read<ImageBloc>().state.data.containsKey(
      widget.imageIdentifier.sku,
    );

    if (!exists) {
      context.read<ImageBloc>().add(
        RetrieveImagesBySkuEvent(sku: widget.imageIdentifier.sku),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ImageBloc,
      ImageState,
      ({bool fetching, WordImage? image})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.imageIdentifier.sku),
          image: state.data[widget.imageIdentifier.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: const AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
          );
        }

        final image = state.image;

        if (image == null) {
          return const Center(child: Text("Image was not found"));
        }

        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 5.0,
          panEnabled: true,
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.memory(
              Uint8List.fromList(base64Decode(image.payload)),
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image);
              },
            ),
          ),
        );
      },
    );
  }
}
