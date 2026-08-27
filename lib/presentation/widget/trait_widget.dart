import 'package:flutter/material.dart';

import 'package:kris/presentation/widget/dialect_widget.dart';

import '../../model/trait.dart';
import 'audio_list_wiget.dart';
import 'language/language_list_widget.dart';

class TraitWidget extends StatelessWidget {
  final Trait trait;

  const TraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SoundListWidget(
            key: ValueKey('sound-${trait.sku}'),
            identifiers: trait.audios,
          ),
        ),

        Expanded(
          flex: 1,
          child: LanguageListWidget(
            key: ValueKey(trait.sku),
            identifiers: [trait.language],
          ),
        ),
      ],
    );
  }
}
