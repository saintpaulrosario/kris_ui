import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../../response/page_result.dart';
import '../screen/word_item_screen.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage> {
  @override
  void initState() {
    context.read<WordBloc>().add(
      RetrieveWordsEvent(pageNumber: 0, pageSize: 15, type: 'WORD'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, WordState>(
      selector: (state) {
        return state;
      },

      builder: (context, state) {
        if (state.fetching.contains("all")) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.pages.isEmpty ||
            state.pages[state.pageNumber] == null) {
          return Text("pages not fetched");
        } else {
          return BlocSelector<WordBloc, WordState, PageResult<Word>>(
            selector: (state) {
              return state.pages[state.pageNumber]!;
            },
            builder: (context, state) {
              return Column(
                children: [
                  WordListScreen(identifiers: state.content),

                  Pagination(
                    numOfPages: state.totalPages,

                    selectedPage: state.number + 1,

                    pagesVisible: state.totalPages > 5 ? 5 : state.totalPages,

                    onPageChanged: (int selectedPage) {
                      context.read<WordBloc>().add(
                        RetrieveWordsEvent(
                          pageNumber: selectedPage - 1,
                          pageSize: state.size,
                          type: '',
                          maya: '',
                        ),
                      );
                    },
                    activeTextStyle: TextStyle(),
                    activeBtnStyle: ButtonStyle(),
                    inactiveTextStyle: TextStyle(),
                    inactiveBtnStyle: ButtonStyle(),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
