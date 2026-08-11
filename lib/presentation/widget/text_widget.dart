import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

class TextWidget extends StatefulWidget {
  // final List<String> sounds;
  // final Identifier identifier;
  const TextWidget({super.key});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("Text");
  }
}
