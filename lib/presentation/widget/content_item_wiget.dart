import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/translation_content.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
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

    context.read<TranslationBloc>().add(
      BaseEvent.contentBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      TranslationState,
      ({bool fetching, TranslationContent? content})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        content: state.contents[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.content == null) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Content not found"),
          );
        }

        if (state.content!.payloads.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No payload found"),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PayloadListWidget(
              key: ValueKey(state.content!.sku),
              identifiers: state.content!.payloads,
            ),
          ],
        );
      },
    );
  }
}
