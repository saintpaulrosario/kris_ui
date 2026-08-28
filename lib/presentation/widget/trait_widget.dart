import 'package:flutter/material.dart';

import '../../model/trait.dart';
import 'audio_list_wiget.dart';

class TraitWidget extends StatelessWidget {
  final Trait trait;

  const TraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SoundListWidget(
        key: ValueKey('sound-${trait.sku}'),
        identifiers: trait.audios,
      ),
    );
  }
}
