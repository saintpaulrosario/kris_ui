import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
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
    context.read<WordBloc>().add(RetrieveWordBySkuEvent(sku: widget.word.sku));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, bool>(
      selector: (state) => state.fetching.contains(widget.word.sku),
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
          selector: (state) => state.data[widget.word.sku],
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
                          ImageListWidget(
                            imagesIdentifiers: widget.word.images,
                          ),
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
