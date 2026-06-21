import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/idenity.dart';

class ImageListWidget extends StatefulWidget {
  final List<Identity> images;

  const ImageListWidget({super.key, required this.images});

  @override
  State<ImageListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ImageListWidget> {
  @override
  void initState() {
    super.initState();
    List<String> skus = widget.images.map((image) => image.sku).toList();
    context.read<ImageBloc>().add(RetrieveImagesBySkusEvent(skus: skus));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ImageBloc, ImageState>(
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
          }

          if (!state.fetching && !state.success) {
            return Container(
              width: double.infinity,
              height: 120,
              color: Colors.grey[200],
              child: const Icon(
                Icons.broken_image,
                size: 40,
                color: Colors.grey,
              ),
            );
          }

          if (state.success) {
            return const Text("No Image");
          }

          // todo get image  now
          final image = state.images.first;

          // Assuming sound.data is Base64 String:
          Uint8List imageBytes = Uint8List.fromList(
            base64Decode(image.payload),
          );
          return Expanded(
            child: Image.memory(
              imageBytes,
              height: double.infinity,
              width: double.infinity,
            ),
          );
        },
      ),
    );
  }
}
