import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/word.dart';

import 'package:kris/presentation/page/word_table_source.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';

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

    context.read<WordBloc>().add(BaseEvent.fetch(pageNumber: 0, pageSize: 10));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, BaseState<Word>, PageResult<Word>?>(
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
