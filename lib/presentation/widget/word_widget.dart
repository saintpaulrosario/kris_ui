import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/word.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../model/identifier.dart';
import '../../model/script.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import 'word_text_list_wiget.dart';

class WordWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;
  final Set<String> visited;

  const WordWidget({
    super.key,
    required this.identifier,
    required this.maya,
    required this.visited,
  });

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.maya == 'SCRIPT') {
      context.read<ScriptBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final visited = {...widget.visited, widget.identifier.sku};

    if (widget.maya == 'SCRIPT' && visited.isNotEmpty) {
      return BlocSelector<
        ScriptBloc,
        BaseState<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, Script? word})
      >(
        selector: (state) {
          return (
            fetching: state.fetching.contains(widget.identifier.sku),
            word: state.data[widget.identifier.sku],
          );
        },

        builder: (context, result) {
          if (result.fetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (result.word == null) {
            return const Center(child: Text("Word not found"));
          }

          return _buildWord(result.word!, visited);
        },
      );
    }

    return BlocSelector<
      TranslationBloc,
      BaseState<
        Translation,
        TranslationText,
        TranslationContent,
        TranslationPayload
      >,
      ({bool fetching, Translation? word})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          word: state.data[widget.identifier.sku],
        );
      },

      builder: (context, result) {
        if (result.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (result.word == null) {
          return const Center(child: Text("Word not found"));
        }

        return _buildWord(result.word!, visited);
      },
    );
  }

  Widget _buildWord(Word word, Set<String> visited) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.maya != 'SCRIPT') Text('${word.ordinal}'),

        WordTextListWidget(
          identifiers: word.texts,
          maya: widget.maya,
          visited: visited,
          key: ValueKey('${word.sku}_${widget.maya}'),
        ),
      ],
    );
  }
}
