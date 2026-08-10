import 'package:flutter/material.dart';
import 'package:kris/presentation/page/word_table_source.dart';

class WordTable extends PaginatedDataTable {
  final WordTableSource wordSource;

  WordTable({super.key, required this.wordSource, required super.columns})
    : super(source: wordSource);
}
