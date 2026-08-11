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
            width: 120,
            child: ImageListWidget(identifiers: word.images),
          ),
        ),

        DataCell(SizedBox(width: 200, child: TextWidget())),

        DataCell(SizedBox(width: 150, child: DialectWidget())),

        DataCell(SizedBox(width: 150, child: LanguageWidget())),

        DataCell(SizedBox(width: 150, child: ScriptWidget())),
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
