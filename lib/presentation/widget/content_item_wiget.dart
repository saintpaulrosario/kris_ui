import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/example_content/bloc/example_content_bloc.dart';

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

    if (widget.identifier.type == 'EXAMPLE') {
      context.read<ExampleContentBloc>().add(
        ExampleContentEventFetchByIdentifier(identifier: widget.identifier),
      );
    } else {
      context.read<ContentBloc>().add(
        ContentEventRetriveByIdentifier(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifier.type == 'EXAMPLE') {
      return BlocSelector<
        ExampleContentBloc,
        ExampleContentState,
        ({bool fetching, Content? content})
      >(
        selector: (state) {
          return (
            fetching: state.fetching.contains(widget.identifier.sku),
            content: state.data[widget.identifier.sku],
          );
        },
        builder: (context, state) {
          return _buildContent(
            content: state.content,
            fetching: state.fetching,
          );
        },
      );
    }

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
        return _buildContent(content: state.content, fetching: state.fetching);
      },
    );
  }

  Widget _buildContent({required bool fetching, required Content? content}) {
    if (fetching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (content == null) {
      return const Center(child: Text("Content not found"));
    }

    if (content.payloads.isEmpty) {
      return const Center(child: Text("No payload found"));
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: PayloadListWidget(
        identifiers: content.payloads,
        key: Key(content.sku),
      ),
    );
  }
}
