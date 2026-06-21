import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
import 'word_item_screen.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WordBloc>().add(RetrieveWordsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      // listenWhen: (previous, current) {
      //   //return current.fetching || previous.fetching;
      //   return true;
      // },
      // listener: (BuildContext context, WordState state) {
      //   context.read<WordBloc>().add(RetrieveWordsEvent());
      // },
      // buildWhen: (previous, current) {
      //   //return previous.fetching || current.fetching;
      //   return true;
      // },
      builder: (context, state) {
        if (state.fetching) {
          return const CircularProgressIndicator();
        }
        if (state.words.isEmpty) {
          return const Text('No words available');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(height: 1.0);
                },
                itemCount: state.words.length,
                itemBuilder: (context, index) {
                  var word = state.words[index];
                  return WordItemScreen(word: word);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
