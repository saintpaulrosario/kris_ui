import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium_state.dart';
import 'package:kris/model/word_image.dart';
import 'package:kris/presentation/widget/image_viewer_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../logic/medium/bloc/medium_bloc.dart';
import '../../model/identifier.dart';

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

    context.read<MediumBloc>().add(
      MediumEventFetch(sku: widget.imageIdentifier.sku),
    );
  }

  @override
  void didUpdateWidget(covariant ImageItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imageIdentifier.sku != widget.imageIdentifier.sku) {
      context.read<MediumBloc>().add(
        MediumEventFetch(sku: widget.imageIdentifier.sku),
      );
    }
  }

  Uint8List _decodeImage(String payload) {
    return Uint8List.fromList(base64Decode(payload));
  }

  void _openViewer(WordImage image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImageViewerWidget(
          identifier: widget.imageIdentifier,
          payload: image.content,
          descriptions: const ['this is a descripont', 'thisis second'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      MediumBloc,
      MediumState,
      ({bool fetching, WordImage? image})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.imageIdentifier.sku),
        image: state.data[widget.imageIdentifier.sku],
      ),
      builder: (context, state) {
        return _buildContent(context, state);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    ({bool fetching, WordImage? image}) state,
  ) {
    if (state.fetching) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: const DecoratedBox(
          decoration: BoxDecoration(color: Colors.white),
        ),
      );
    }

    final image = state.image;

    if (image == null) {
      return const Center(
        child: Text('Image was not found', textAlign: TextAlign.center),
      );
    }

    return InkWell(
      onTap: () => _openViewer(image),
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
