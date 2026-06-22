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
    final image = widget.images.first;
    return ImageItemWidget(image: image);
    // return BlocBuilder<ImageBloc, ImageState>(
    //   builder: (context, state) {
    //     if (state.fetching) {
    //       return Shimmer.fromColors(
    //         baseColor: Colors.grey[300]!,
    //         highlightColor: Colors.grey[100]!,
    //         child: Container(
    //           width: double.infinity,
    //           height: double.infinity,
    //           color: Colors.white,
    //         ),
    //       );
    //     }

    //     if (!state.fetching && !state.success) {
    //       return FittedBox(
    //         fit: BoxFit.contain,
    //         child: const Icon(
    //           Icons.broken_image,
    //           size: 40,
    //           color: Colors.grey,
    //         ),
    //       );
    //     }

    //     // todo get image  now
    //     final image = state.images.first;
    //     return ImageItemWidget(image: image);
    //   },
    // );
  }
}
