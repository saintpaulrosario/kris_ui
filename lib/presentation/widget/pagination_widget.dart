import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/word.dart';
import 'package:kris/response/page_result.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/base_event.dart';
import '../../logic/word/translation_bloc.dart';

class PaginationWidget extends StatelessWidget {
  final PageResult<Word> pages;

  const PaginationWidget({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Pagination(
      numOfPages: pages.page.totalPages,
      selectedPage: pages.page.number + 1,
      pagesVisible: pages.page.totalPages > 5 ? 5 : pages.page.totalPages,
      onPageChanged: (int selectedPage) {
        context.read<TranslationBloc>().add(
          BaseEvent.fetch(
            pageNumber: selectedPage - 1,
            pageSize: pages.page.size,
          ),
        );
      },
      activeTextStyle: const TextStyle(),
      activeBtnStyle: const ButtonStyle(),
      inactiveTextStyle: const TextStyle(),
      inactiveBtnStyle: const ButtonStyle(),
    );
  }
}
