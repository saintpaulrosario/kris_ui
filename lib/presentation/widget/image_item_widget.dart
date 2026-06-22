import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:shimmer/shimmer.dart';
import '../../logic/image/bloc/image_bloc.dart';

class ImageItemWidget extends StatefulWidget {
  final Identifier image;

  const ImageItemWidget({super.key, required this.image});

  @override
  State<ImageItemWidget> createState() => _ImageItemWidgetState();
}

class _ImageItemWidgetState extends State<ImageItemWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ImageBloc>().add(
      RetrieveImagesBySkuEvent(sku: '08a82050-6ad7-4ff3-bbb7-41927412a49d'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageBloc, ImageState>(
      builder: (context, state) {
        if (state.fetching) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          );
        } else if (state.failure || !state.fetching) {
          return FittedBox(
            fit: BoxFit.contain,
            child: const Icon(Icons.broken_image, size: 44, color: Colors.grey),
          );
        } else {
          Uint8List imageBytes = Uint8List.fromList(
            base64Decode(state.image.payload),
          );
          return Expanded(
            child: Image.memory(
              imageBytes,
              height: double.infinity,
              width: double.infinity,
            ),
          );
        }
      },
    );
  }
}
