import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/word_detail.dart';

import 'package:kris/presentation/page/word_table_source.dart';
import 'package:kris/presentation/widget/dialect_widget.dart';
import 'package:kris/presentation/widget/image_list_widget.dart';
import 'package:kris/presentation/widget/language_widget.dart';
import 'package:kris/presentation/widget/script_widget.dart';
import 'package:kris/presentation/widget/text_widget.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../logic/word/detail/word_detail_bloc.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
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

    context.read<WordDetailBloc>().add(
      WordDetailEvent(
        page: 0,
        size: 10,
        scripts: [],
        dialects: [],
        languages: [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordDetailBloc,
      WordDetailState,
      PageResult<WordDetail>?
    >(
      selector: (state) {
        return state.pages[state.pageNumber];
      },
      builder: (context, state) {
        if (state == null) {
          return const Center(child: CircularProgressIndicator());
        }
        List<DataColumn> columns = [
          DataColumn(label: Text("Image")),
          DataColumn(label: Text("Text")),
          DataColumn(label: Text("Dialect")),
          DataColumn(label: Text("Language")),
          DataColumn(label: Text("Script")),
        ];
        WordTableSource source = WordTableSource(words: state.content);
        return PaginatedDataTable(
          header: Center(child: Text('Translation')),
          columns: columns,
          rowsPerPage: state.page.size,
          source: source,
        );
      },
    );
  }
}
