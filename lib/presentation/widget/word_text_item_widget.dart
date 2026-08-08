import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';
import 'word_widget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;
  final Set visited;
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
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return _buildTranslation(context, text);
      },
    );
  }

  Widget _buildTranslation(BuildContext context, TranslationText text) {
    final bool scriptVisited = widget.visited.contains(text.script.sku);

    final Set<String> nextVisited = {...widget.visited, text.sku};

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ====================================================
          // TEXT COLUMN
          // ====================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ContentListWidget(
                key: ValueKey('${text.sku}_content'),
                identifiers: text.contents,
                maya: widget.maya,
              ),
            ),
          ),

          // ====================================================
          // VERTICAL DIVIDER
          // ====================================================
          Container(width: 1, color: Theme.of(context).dividerColor),

          // ====================================================
          // SCRIPT COLUMN
          // ====================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: scriptVisited
                  ? const SizedBox.shrink()
                  : WordWidget(
                      key: ValueKey('${text.script.sku}_script'),
                      identifier: text.script,
                      maya: 'SCRIPT',
                      visited: nextVisited,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
