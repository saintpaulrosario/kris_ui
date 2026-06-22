import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../widget/content_list_widget.dart';
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
    super.initState();

    context.read<WordBloc>().add(RetrieveWordBySkuEvent(sku: widget.word.sku));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.fetching == true) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.failure == true) {
          return const Center(child: Text('Failed to retrieve word'));
        } else if (state.success == true && state.failure == false) {
          final word = state.selection;
          // maybe iterate over text?
          return Card(
            margin: const EdgeInsets.all(8),
            child: SizedBox(
              height: 150, // important: bounded height
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// texts
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Text',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: WordTextListWidget(texts: word.texts),
                          ),
                        ],
                      ),
                    ),

                    /// Images belong to a word
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Images',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(child: ImageListWidget(images: word.images)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text('No word available'));
        }
      },
    );
  }
}
