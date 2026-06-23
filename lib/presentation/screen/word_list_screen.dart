import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';

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

  // do define the headers?
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.fetching == true) {
          return const CircularProgressIndicator();
        } else if (state.failure == true) {
          return const Text('Failed to retrieve words');
        } else if (state.success == true) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: state.words
                  .map((word) => ListTile(title: WordItemScreen(word: word)))
                  .toList(),
            ),
          );
        } else {
          return const Text('No words available');
        }
      },
    );
  }
}
