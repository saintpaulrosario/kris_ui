import 'package:flutter/material.dart';

import 'package:kris/presentation/widget/dialect_widget.dart';

import '../../model/trait.dart';
import 'audio_list_wiget.dart';

class TraitWidget extends StatelessWidget {
  final Trait trait;

  const TraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Expanded(flex: 1, child: DialectWidget(identifier: trait.dialect)),
        SoundListWidget(
          key: ValueKey('sound-${trait.sku}'),
          identifiers: trait.audios,
        ),
      ],
    );
  }
}
