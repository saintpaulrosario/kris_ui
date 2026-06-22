import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/word_text.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/identifier.dart';
import '../../model/script.dart';

class WordTextItemWidget extends StatefulWidget {
  final Identifier textIdentifier;

  const WordTextItemWidget({super.key, required this.textIdentifier});

  @override
  State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
}

class _WordTextItemWidgetState extends State<WordTextItemWidget> {
  @override
  void initState() {
    super.initState();
    //context.read<TextBloc>().add(RetrieveWordBySkuEvent(sku: widget.textIdentifier.sku));
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.textIdentifier.sku);
  }
}
