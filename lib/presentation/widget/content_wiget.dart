import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/language.dart';

import 'language/language_list_widget.dart';
import 'payload_list_widget.dart';

class ContentWidget extends StatefulWidget {
  final Identifier identifier;

  const ContentWidget({super.key, required this.identifier});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<TranslationBloc>().add(
      BaseEvent.content(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) =>
          previous.selections != current.selections,

      listener: (context, state) {
        context.read<TranslationBloc>().add(
          BaseEvent.content(identifier: widget.identifier),
        );
      },

      child:
          BlocSelector<
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
                  child: Text('Content not found'),
                );
              }

              final content = state.content!;

              if (content.payloads.isEmpty) {
                return const Text('No payload found');
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PayloadListWidget(
                      key: ValueKey(content.sku),
                      identifiers: content.payloads,
                    ),
                  ),
                  Expanded(
                    child: LanguageListWidget(
                      key: ValueKey(content.sku),
                      identifiers: content.languages,
                    ),
                  ),
                ],
              );
            },
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
