import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';

import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/word.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../model/dialect.dart';
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
    } else if (widget.maya == 'DIALECT') {
      context.read<DialectBloc>().add(
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
    if (widget.maya == 'SCRIPT' && widget.visited.isNotEmpty) {
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

        builder: (context, state) {
          if (state.fetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.word == null) {
            return const Center(child: Text("Word not found"));
          }

          return widget.visited.contains(widget.identifier.sku)
              ? WordTextListWidget(
                  identifiers: state.word!.texts,
                  maya: widget.maya,
                  visited: {...widget.visited, widget.identifier.sku},
                  key: ValueKey('${widget.identifier.sku}_${widget.maya}'),
                )
              : SizedBox.shrink();
        },
      );
    }
    if (widget.maya == 'DIALECT' && widget.visited.isNotEmpty) {
      return BlocSelector<
        DialectBloc,
        BaseState<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, Dialect? word})
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

          return widget.visited.contains(widget.identifier.sku)
              ? WordTextListWidget(
                  identifiers: result.word!.texts,
                  maya: widget.maya,
                  visited: {...widget.visited, widget.identifier.sku},
                  key: ValueKey('${widget.identifier.sku}_${widget.maya}'),
                )
              : SizedBox.shrink();
        },
      );
    } else {
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WordTextListWidget(
                identifiers: result.word!.texts,
                maya: widget.maya,
                visited: {...widget.visited, widget.identifier.sku},
                key: ValueKey('${widget.identifier.sku}_${widget.maya}'),
              ),
            ],
          );
        },
      );
    }
  }
}
