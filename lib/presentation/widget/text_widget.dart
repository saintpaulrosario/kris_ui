import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

class TextWidget extends StatefulWidget {
  final Identifier text;
  final Identifier script;
  const TextWidget({super.key, required this.text, required this.script});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
