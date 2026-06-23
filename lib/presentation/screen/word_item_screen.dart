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
    super.initState();

    context.read<WordTextBloc>().add(
      WordTextEventRetrieveByWordSku(sku: widget.word.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordTextBloc, WordTextState>(
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.failure) {
          return const Center(child: Text('Failed to retrieve word'));
        }

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
                      Text(widget.word.sku),
                      WordTextListWidget(textsIdentifiers: state.texts),
                    ],
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Images',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      // LineDivider(),
                      ImageListWidget(imagesIdentifiers: widget.word.images),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
