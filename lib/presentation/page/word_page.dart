import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/text.dart' as w;

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

    context.read<TranslationBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      BaseState<Translation, w.Text, Content, Payload>,
      PageResult<Translation>?
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
        ];
        WordTableSource source = WordTableSource(words: state.content);
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  header: const Center(child: Text('Translation')),
                  columns: columns,
                  rowsPerPage: state.page.size,
                  dataRowMinHeight: 50,
                  dividerThickness: 1,
                  dataRowMaxHeight: double.infinity,
                  source: source,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
