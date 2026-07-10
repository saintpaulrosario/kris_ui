import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../widget/image_list_widget.dart';

class WordItemScreen extends StatelessWidget {
  final Word word;

  const WordItemScreen({super.key, required this.word});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, bool>(
      selector: (state) => state.fetching.contains(word.sku),
      builder: (context, fetching) {
        if (fetching) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BlocSelector<WordBloc, WordState, Word?>(
          selector: (state) => state.data[word.sku],
          builder: (context, state) {
            if (state == null) {
              return const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text("Word text not found"),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ImageListWidget(imagesIdentifiers: word.images),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text("definition")],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          WordTextListWidget(identifiers: state.texts),
                        ],
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
