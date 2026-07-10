import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../model/content.dart';
import '../../model/identifier.dart';
import 'payload_list_widget.dart';

class ContentItemWidget extends StatefulWidget {
  final Identifier identifier;

  const ContentItemWidget({super.key, required this.identifier});

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    super.initState();

    _retrieveContent();
  }

  @override
  void didUpdateWidget(covariant ContentItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.identifier.sku != widget.identifier.sku) {
      _retrieveContent();
    }
  }

  void _retrieveContent() {
    final exists = context.read<ContentBloc>().state.data.containsKey(
      widget.identifier.sku,
    );

    if (!exists) {
      context.read<ContentBloc>().add(
        ContentEventRetriveBySku(widget.identifier.sku),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ContentBloc,
      ContentState,
      ({bool fetching, Content? content})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.data[widget.identifier.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        final content = state.content;

        if (content == null) {
          return const Center(child: Text("Content not found"));
        }

        if (content.payloads.isEmpty) {
          return const Text("No payload found");
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: PayloadListWidget(identifiers: content.payloads),
        );
      },
    );
  }
}
