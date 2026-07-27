import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/example_content/bloc/example_content_bloc.dart';
import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/content/content.dart';
import '../../logic/identifier.dart';
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
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.data[widget.identifier.sku],
        ),
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
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        content: state.data[widget.identifier.sku],
      ),
      builder: (context, state) {
        return _buildContent(content: state.content, fetching: state.fetching);
      },
    );
  }

  Widget _buildContent({required bool fetching, required Content? content}) {
    if (fetching) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (content == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("Content not found"),
      );
    }

    if (content.payloads.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("No payload found"),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(child: Text("definition", textAlign: TextAlign.center)),
        ),

        Expanded(
          flex: 4,
          child: PayloadListWidget(
            key: ValueKey(content.sku),
            identifiers: content.payloads,
          ),
        ),
      ],
    );
  }
}
