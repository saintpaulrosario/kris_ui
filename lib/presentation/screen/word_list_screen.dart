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
    context.read<WordBloc>().add(RetrieveWordsEvent());
    super.initState();
  }

  // do define the headers?
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.fetching == true && state.success == false) {
          return const CircularProgressIndicator();
        } else if (state.success == false && state.fetching == false) {
          return const Text('no words yet available');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.words.length,
                  itemBuilder: (context, index) {
                    Word word = state.words[index];
                    return WordItemScreen(word: word);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
