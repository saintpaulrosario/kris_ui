import 'package:flutter/material.dart';

import '../../model/identifier.dart';

class WordWidget extends StatefulWidget {
  final Identifier text;
  final Identifier script;
  final Identifier dialect;
  final Identifier language;
  final Identifier image;
  final Identifier sound;
  final Identifier definition;

  const WordWidget({
    super.key,
    required this.text,
    required this.script,
    required this.dialect,
    required this.language,
    required this.image,
    required this.sound,
    required this.definition,
  });

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text("data");
  }
}
