import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/word.dart';
import '../../model/word_text.dart';
import '../widget/content_list_widget.dart';
import '../widget/image_list_widget.dart';

class WordItemScreen extends StatefulWidget {
  final Word word;

  const WordItemScreen({super.key, required this.word});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    super.initState();

    context.read<WordTextBloc>().add(
      WordTextEventRetrieveByWordSku(wordSku: widget.word.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordTextBloc, WordTextState, bool>(
      selector: (state) => state.loading.contains(widget.word.sku),
      builder: (context, loading) {
        if (loading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BlocSelector<WordTextBloc, WordTextState, WordText?>(
          selector: (state) => state.texts[widget.word.sku],
          builder: (context, wordText) {
            if (wordText == null) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Word text not found"),
                ),
              );
            }

            return Card(
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.word.sku), // change to your field

                          ContentListWidget(identifiers: wordText.contents),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ImageListWidget(
                        imagesIdentifiers: widget.word.images,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
