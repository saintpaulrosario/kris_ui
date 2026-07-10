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
    return BlocSelector<
      WordBloc,
      WordState,
      ({bool loading, List<Word> words})
    >(
      selector: (state) {
        return (
          loading: state.fetching.contains("all"),
          words: state.data.values.toList(),
        );
      },
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.words.isEmpty) {
          return const Center(child: Text("No words found"));
        }

        return ListView.builder(
          itemCount: state.words.length,
          itemBuilder: (context, index) {
            return WordItemScreen(word: state.words[index]);
          },
        );
      },
    );
  }
}
