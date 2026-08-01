import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../../response/page_result.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(WordEventFetch(pageNumber: 0, pageSize: 15));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, PageResult<Word>?>(
      selector: (state) {
        return state.pages[state.pageNumber];
      },
      builder: (context, state) {
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: WordListScreen(
                  key: Key("WORD"),
                  identifiers: state.content,
                ),
              ),
            ),

            Pagination(
              numOfPages: state.page.totalPages,
              selectedPage: state.page.number + 1,
              pagesVisible: state.page.totalPages > 5
                  ? 5
                  : state.page.totalPages,

              onPageChanged: (int selectedPage) {
                context.read<WordBloc>().add(
                  WordEventFetch(
                    pageNumber: selectedPage - 1,
                    pageSize: state.page.size,
                  ),
                );
              },

              activeTextStyle: const TextStyle(),
              activeBtnStyle: const ButtonStyle(),
              inactiveTextStyle: const TextStyle(),
              inactiveBtnStyle: const ButtonStyle(),
            ),
          ],
        );
      },
    );
  }
}
