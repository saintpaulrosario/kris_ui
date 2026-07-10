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
  final ScrollController _scrollController = ScrollController();

  int page = 0;
  final int size = 10;

  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(RetrieveWordsEvent(page: page, size: size));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 300) {
        final state = context.read<WordBloc>().state;

        if (!state.fetching.contains("all") && !state.page.last) {
          page++;

          context.read<WordBloc>().add(
            RetrieveWordsEvent(page: page, size: size),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      WordState,
      ({bool loading, List<Word> words, bool lastPage})
    >(
      selector: (state) {
        return (
          loading: state.fetching.contains("all"),
          words: state.data.values.toList(),
          lastPage: state.page.last,
        );
      },

      builder: (context, state) {
        if (state.words.isEmpty && state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.words.isEmpty) {
          return const Center(child: Text("No words found"));
        }

        return ListView.builder(
          controller: _scrollController,

          itemCount: state.words.length + (state.loading ? 1 : 0),

          itemBuilder: (context, index) {
            if (index == state.words.length) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            return WordItemScreen(word: state.words[index]);
          },
        );
      },
    );
  }
}
