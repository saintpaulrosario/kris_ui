import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation_text.dart';
import 'content_list_widget.dart';

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
    return BlocSelector<
      TranslationBloc,
      TranslationState,
      ({bool fetching, TranslationText? text})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        text: state.texts[widget.identifier.sku],
      ),

      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.text == null) {
          return const Text("Text not found");
        }

        if (state.text!.contents.isEmpty) {
          return const Text("No content found");
        }

        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Content column - LEFT
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ContentListWidget(
                    identifiers: state.text!.contents,
                    key: ValueKey(state.text!.sku),
                  ),
                ),
              ),

              // Divider
              const VerticalDivider(thickness: 1, width: 1, color: Colors.grey),

              // Script column - CENTER
              Expanded(
                child: Center(
                  child: Text("script", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
