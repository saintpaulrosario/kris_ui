import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/translation.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import 'word_text_list_wiget.dart';

class WordWidget extends StatefulWidget {
  final Identifier identifier;

  const WordWidget({super.key, required this.identifier});

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  @override
  void initState() {
    super.initState();

    context.read<TranslationBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslationBloc, TranslationState>(
      builder: (context, state) {
        final Translation? word = state.data[widget.identifier.sku];

        if (state.fetching.contains(widget.identifier.sku)) {
          return const Center(child: CircularProgressIndicator());
        }

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
              WordTextListWidget(identifiers: word.texts),
          ],
        );
      },
    );
  }
}
