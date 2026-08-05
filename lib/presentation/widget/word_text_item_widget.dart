import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/presentation/widget/word_widget.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;

  const WordTextItemWidget({
    super.key,
    required this.identifier,
    required this.maya,
  });

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    super.initState();

    if ('SCRIPT' == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.textBySku(identifier: widget.identifier),
      );
    }

    if ('LANGUAGE' == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.textBySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.textBySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maya == 'SCRIPT') {
      return BlocSelector<ScriptBloc, ScriptState, TranslationText?>(
        selector: (state) => state.texts[widget.identifier.sku],

        builder: (context, text) {
          return _buildWidget(text);
        },
      );
    } else if (widget.maya == 'LANGUAGE') {
      return BlocSelector<LanguageBloc, LanguageState, TranslationText?>(
        selector: (state) => state.texts[widget.identifier.sku],

        builder: (context, text) {
          return _buildWidget(text);
        },
      );
    } else {
      return BlocSelector<TranslationBloc, TranslationState, TranslationText?>(
        selector: (state) => state.texts[widget.identifier.sku],

        builder: (context, text) {
          return _buildWidget(text);
        },
      );
    }
  }

  Widget _buildWidget(TranslationText? text) {
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

              identifiers: text.contents,
              maya: widget.maya,
            ),
          ),

          // Expanded(
          //   child: WordWidget(
          //     key: ValueKey('${text.script.sku}_${widget.maya}'),
          //     identifier: text.script,
          //     maya: 'SCRIPT',
          //   ),
          // ),
        ],
      ),
    );
  }
}
