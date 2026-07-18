import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';

class WordDetailPage extends StatefulWidget {
  final String sku;
  const WordDetailPage({super.key, required this.sku});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    Identifier identifier = Identifier(
      sku: widget.sku,
      version: 0,
      ordinal: 0,
      createdDate: DateTime.now(),
      lastModifiedDate: DateTime.now(),
      createdBy: '',
      lastModifiedBy: '',
      type: 'WORD',
    );

    context.read<WordBloc>().add(
      RetrieveWordBySkuEvent(identifier: identifier),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordBloc, WordState, ({bool fetching, Word? word})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.sku),
          word: state.data[widget..sku],
        );
      },
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
