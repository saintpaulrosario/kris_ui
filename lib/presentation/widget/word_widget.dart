import 'package:flutter/material.dart';

import 'package:kris/model/translation.dart';

import 'package:kris/presentation/widget/transcription/transcription_wdiget.dart';
import 'package:kris/presentation/widget/translation/translation_widget.dart';

import 'transliteration/transcription_wdiget.dart';

class WordWidget extends StatelessWidget {
  final Translation translation;
  //todo make clickable

  const WordWidget({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TranslationWidget(translation: translation),
          TranscriptionWdiget(),
          TransliterationWdiget(),
        ],
      ),
    );
  }
}
