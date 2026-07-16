import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
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
    context.read<WordBloc>().add(
      RetrieveWordsEvent(pageNumber: 0, pageSize: 120, type: 'WORD'),
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.content.length,

                      itemBuilder: (context, index) {
                        final word = state.content.elementAt(index);

                        return WordItemScreen(
                          key: ValueKey(word.sku),
                          identifier: Identifier(
                            sku: word.sku,
                            version: word.version,
                            ordinal: word.ordinal,
                            createdDate: word.createdDate,
                            lastModifiedDate: word.lastModifiedDate,
                            createdBy: word.createdBy,
                            lastModifiedBy: word.lastModifiedBy,
                            type: word.type,
                          ),
                        );
                      },
                    ),
                  ),

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
