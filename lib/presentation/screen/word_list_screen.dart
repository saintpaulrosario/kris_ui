import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
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
    return BlocSelector<WordBloc, WordState, WordState>(
      selector: (state) => state,
      builder: (context, state) {
        if (state.fetching && !state.success) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!state.success) {
          return const Center(child: Text("No words available"));
        }

        return ListView.builder(
          itemCount: state.words.length,
          itemBuilder: (context, index) {
            final word = state.words.values.elementAt(index);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: WordItemScreen(word: word),
            );
          },
        );
      },
    );
  }
}
