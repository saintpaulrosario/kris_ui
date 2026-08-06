import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/translation_text.dart';
import 'package:kris/model/word.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import 'word_text_list_wiget.dart';

class WordWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;

  const WordWidget({super.key, required this.identifier, required this.maya});

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  @override
  void initState() {
    super.initState();

    if ('SCRIPT' == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    } else if ('LANGUAGE' == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    } else if ('DIALECT' == widget.maya) {
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
    if ('SCRIPT' == widget.maya) {
      return BlocBuilder<ScriptBloc, ScriptState>(
        builder: (context, state) {
          final Translation? word = state.data[widget.identifier.sku];

          if (state.fetching.contains(widget.identifier.sku)) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildWidget(word: word);
        },
      );
    } else if ('LANGUAGE' == widget.maya) {
      return BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          final Translation? word = state.data[widget.identifier.sku];

          if (state.fetching.contains(widget.identifier.sku)) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildWidget(word: word);
        },
      );
    } else if ('DIALECT' == widget.maya) {
      return BlocBuilder<DialectBloc, DialectState>(
        builder: (context, state) {
          final Translation? word = state.data[widget.identifier.sku];

          if (state.fetching.contains(widget.identifier.sku)) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildWidget(word: word);
        },
      );
    } else {
      return BlocBuilder<TranslationBloc, TranslationState>(
        builder: (context, state) {
          final Translation? word = state.data[widget.identifier.sku];

          if (state.fetching.contains(widget.identifier.sku)) {
            return const Center(child: CircularProgressIndicator());
          }
          //return Text("data");
          return _buildWidget(word: word);
        },
      );
    }
  }

  Widget _buildWidget({Translation? word}) {
    if (word == null) {
      return const Center(child: Text("Word not found"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          word.ordinal.toString(),
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 10),

        if (word.texts.isNotEmpty)
          WordTextListWidget(
            identifiers: word.texts,
            maya: widget.maya,
            key: ValueKey('${word.sku}_${widget.maya}'),
          ),
      ],
    );
  }
}
