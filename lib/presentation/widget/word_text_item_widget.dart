import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';
import 'script_wiget.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier identifier;

  const WordTextItemWidget({super.key, required this.identifier});

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
    return BlocSelector<TranslationBloc, TranslationState, TranslationText?>(
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

                  identifiers: text.contents,
                ),
              ),

              Expanded(
                child: ScriptWidget(
                  key: ValueKey('${text.script.sku}_script'),

                  identifier: text.script,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
