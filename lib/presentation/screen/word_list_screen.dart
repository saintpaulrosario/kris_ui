import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../../response/page_result.dart';
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

    context.read<WordBloc>().add(
      RetrieveWordsEvent(pageNumber: 0, pageSize: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      WordState,
      ({bool fetching, int pageSize, PageResult<Word>? page})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains("all"),

          pageSize: state.pageSize,

          page: state.pages[state.pageNumber],
        );
      },

      builder: (context, state) {
        final page = state.page;

        if (state.fetching && page == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (page == null) {
          return const Center(child: Text("No page data"));
        }

        if (page.content.isEmpty) {
          return const Center(child: Text("No words found"));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: page.content.length,

                itemBuilder: (context, index) {
                  final word = page.content.elementAt(index);

                  return WordItemScreen(word: word);
                },
              ),
            ),

            Pagination(
              numOfPages: page.totalPages,

              // pagination_flutter starts at 1
              selectedPage: page.number + 1,

              pagesVisible: 5,

              onPageChanged: (int selectedPage) {
                context.read<WordBloc>().add(
                  RetrieveWordsEvent(
                    // Spring Data starts at 0
                    pageNumber: selectedPage - 1,

                    pageSize: state.pageSize,
                  ),
                );
              },

              activeTextStyle: const TextStyle(),

              activeBtnStyle: ButtonStyle(),

              inactiveTextStyle: const TextStyle(),

              inactiveBtnStyle: ButtonStyle(),
            ),
          ],
        );
      },
    );
  }
}
