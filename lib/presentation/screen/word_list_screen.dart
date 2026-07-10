import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../screen/word_item_screen.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WordBloc>().add(RetrieveWordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, bool>(
      selector: (state) => state.fetching.isNotEmpty,
      builder: (context, fetching) {
        if (fetching) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        return BlocSelector<WordBloc, WordState, Map<String, Word>>(
          selector: (state) {
            return state.data;
          },
          builder: (context, state) {
            if (state.isEmpty) {
              return Text("not a word found");
            }
            return ListView.builder(
              itemCount: state.values.length,
              itemBuilder: (context, index) {
                final word = state.values.elementAt(index);

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Card(child: WordItemScreen(word: word)),
                );
              },
            );
          },
        );
      },
    );
  }
}
