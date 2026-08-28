import 'package:flutter/material.dart';

import 'package:kris/model/translation.dart';

import 'package:kris/presentation/widget/transcription/transcription_wdiget.dart';
import 'package:kris/presentation/widget/translation/translation_widget.dart';

import 'transliteration/transcription_wdiget.dart';

class WordWidget extends StatelessWidget {
  final Translation translation;

  const WordWidget({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TranslationWidget(translation: translation),
        TranscriptionWdiget(),
        TransliterationWdiget(),
      ],
    );
  }
}
