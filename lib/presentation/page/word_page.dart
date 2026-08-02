import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
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
    super.initState();

    context.read<TranslationBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      BaseState<
        Translation,
        TranslationText,
        TranslationContent,
        TranslationPayload
      >,
      PageResult<Translation>?
    >(
      selector: (state) {
        return state.pages[state.pageNumber];
      },
      builder: (context, state) {
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: const Row(
                children: [
                  Expanded(child: Text("Image", textAlign: TextAlign.center)),
                  Expanded(
                    child: Text("Definition", textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text("Translation", textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.content.length,
              itemBuilder: (context, index) {
                final identifier = state.content[index];

                return Row(
                  children: [
                    Expanded(child: Text("Image")),
                    Expanded(child: Text("Definition")),

                    Expanded(child: WordItemScreen(identifier: identifier)),
                  ],
                );
              },
            ),

            Pagination(
              numOfPages: state.page.totalPages,
              selectedPage: state.page.number + 1,
              pagesVisible: state.page.totalPages > 5
                  ? 5
                  : state.page.totalPages,

              onPageChanged: (int selectedPage) {
                context.read<TranslationBloc>().add(
                  BaseEvent.fetch(
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
