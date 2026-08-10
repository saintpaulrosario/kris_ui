import 'package:flutter/material.dart';
import 'package:kris/model/word_detail.dart';
import 'package:kris/response/page_result.dart';

class WordTableSource extends DataTableSource {
  final PageResult<WordDetail> page;

  WordTableSource({required this.page});
  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text("data")),
        DataCell(Text("data")),
        DataCell(Text("data")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => page.content.length;

  @override
  int get selectedRowCount => throw UnimplementedError();
}
