import 'package:flutter/material.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/image_list_widget.dart';
import 'package:kris/presentation/widget/text_list_wiget.dart';

class WordTableSource extends DataTableSource {
  final List<Word> words;

  WordTableSource({required this.words});

  @override
  DataRow? getRow(int index) {
    final word = words[index];
    final texts = word.texts;

    return DataRow(
      cells: [
        DataCell(ImageListWidget(identifiers: word.images)),

        DataCell(TextListWidget(identifiers: texts)),
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
