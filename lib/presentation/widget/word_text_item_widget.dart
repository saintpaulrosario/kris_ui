import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/model/script.dart';
import 'package:uuid/uuid.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/dialect.dart';
import '../../model/identifier.dart';
import '../../model/language.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';
import 'word_widget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;
  final Set<String> visited;
  final String maya;

  const WordTextItemWidget({
    super.key,
    required this.identifier,
    required this.visited,
    required this.maya,
  });

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    super.initState();

    context.read<TranslationBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      BaseState<
        Translation,
        TranslationText,
        TranslationContent,
        TranslationPayload
      >,
      TranslationText?
    >(
      selector: (state) => state.texts[widget.identifier.sku],

      builder: (context, text) {
        if (text == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          width: double.infinity,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Expanded(
                child: ContentListWidget(
                  key: ValueKey(text.sku),
                  identifiers: text.contents, maya: widget.maya,
                ),
              ),
              if (widget.visited.isEmpty)
                Expanded(
                  child: WordWidget(
                    key: ValueKey(text.sku),
                    identifier: text.script,
                    visited: {...widget.visited, text.sku},
                    maya: 'SCRIPT',
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
