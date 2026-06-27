import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/text/bloc/word_text_bloc.dart';
import '../../model/word.dart';
import '../widget/image_list_widget.dart';
import '../widget/word_text_list_wiget.dart';

class WordItemScreen extends StatefulWidget {
  final Word word;

  const WordItemScreen({super.key, required this.word});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    context.read<WordTextBloc>().add(
      WordTextEventRetrieveByWordSku(wordSku: widget.word.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordTextBloc, WordTextState>(
      builder: (context, state) {
        if (state.fetching == true && state.success == false) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.success == false && state.fetching == false) {
          return const Center(child: Text('no words yet available'));
        } else {
          return Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 10,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("word sku: ${widget.word.sku}"),
                        // we get a single text
                        WordTextListWidget(texts: state.texts),
                      ],
                    ),
                  ),

                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LineDivider(),
                        ImageListWidget(imagesIdentifiers: widget.word.images),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
