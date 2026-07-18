import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/content/bloc/content_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/logic/text/bloc/word_text_bloc.dart';
import 'package:kris/logic/word/bloc/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/word.dart';
import 'package:kris/model/word_text.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

class WordDetailPage extends StatefulWidget {
  final Identifier identifier;

  const WordDetailPage({super.key, required this.identifier});

  @override
  State<WordDetailPage> createState() => _WordDetailPageState();
}

class _WordDetailPageState extends State<WordDetailPage> {
  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      RetrieveWordBySkuEvent(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [WordItemScreen(identifier: widget.identifier)]);
  }
}
