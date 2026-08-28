import 'package:flutter/material.dart';

class TransliterationWdiget extends StatefulWidget {
  const TransliterationWdiget({super.key});

  @override
  State<TransliterationWdiget> createState() => _TransliterationWdigetState();
}

class _TransliterationWdigetState extends State<TransliterationWdiget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Text("some transliteration")),
          Flexible(child: Text("transliteration")),
        ],
      ),
    );
  }
}
