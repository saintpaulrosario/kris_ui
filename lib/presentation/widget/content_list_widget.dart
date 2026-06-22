import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../model/identifier.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> contents;

  const ContentListWidget({super.key, required this.contents});

  @override
  State<ContentListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ContentListWidget> {
  @override
  void initState() {
    super.initState();
    //List<String> skus = widget.images.map((image) => image.sku).toList();
    //context.read<ImageBloc>().add(RetrieveImagesBySkusEvent(skus: skus));
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
          // final content = state.images.first;
          return const Text("No content available");
        },
      ),
    );
  }
}
