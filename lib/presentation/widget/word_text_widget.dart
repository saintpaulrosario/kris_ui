import 'package:flutter/material.dart';

import '../../model/word_text.dart';

class WordTextWidget extends StatefulWidget {
  final WordText text;

  const WordTextWidget({super.key, required this.text});

  @override
  State<WordTextWidget> createState() => _WordTextWidgetState();
}

class _WordTextWidgetState extends State<WordTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: widget.text.contents.length,
      itemBuilder: (context, index) {
        //final content = widget.contents[index];
        return Text("text");
      },
    );
  }
}
