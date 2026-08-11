import 'package:flutter/material.dart';
import 'package:kris/model/word_detail.dart';
import 'package:kris/presentation/widget/dialect_widget.dart';
import 'package:kris/presentation/widget/image_list_widget.dart';
import 'package:kris/presentation/widget/language_widget.dart';
import 'package:kris/presentation/widget/script_widget.dart';
import 'package:kris/presentation/widget/text_widget.dart';

class WordTableSource extends DataTableSource {
  final List<WordDetail> words;

  WordTableSource({required this.words});

  @override
  DataRow? getRow(int index) {
    final word = words[index];

    return DataRow(
      cells: [
        DataCell(
          SizedBox(
            width: 150,
            height: 150,
            child: ImageListWidget(identifiers: word.images),
          ),
        ),

        DataCell(TextWidget()),

        DataCell(DialectWidget()),

        DataCell(LanguageWidget()),

        DataCell(ScriptWidget()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => words.length;

  @override
  int get selectedRowCount => 0;
}
