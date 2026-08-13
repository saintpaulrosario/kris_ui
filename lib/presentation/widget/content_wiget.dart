import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../model/identifier.dart';
import '../../model/translation.dart';
import 'package:kris/model/text.dart' as w;

import 'payload_list_widget.dart';

class ContentWidget extends StatefulWidget {
  final Identifier identifier;
  const ContentWidget({super.key, required this.identifier});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
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
      BaseState<Translation, w.Text, Content, Payload>,
      ({bool fetching, Content? content})
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
            child: Text("script Content not found"),
          );
        }

        if (state.content!.payloads.isEmpty) {
          return Text("No payload found");
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PayloadListWidget(
                key: ValueKey(state.content!.sku),
                identifiers: state.content!.payloads,
              ),
            ),

            //const SizedBox(width: 12),
            //LanguageListWidget(identifiers: state.content!.languages),
          ],
        );
      },
    );
  }
}
