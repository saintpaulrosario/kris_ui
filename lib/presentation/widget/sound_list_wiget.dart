import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'sound_item_wiget.dart';

class SoundListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return Icon(Icons.audio_file);
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: identifiers.length,
      itemBuilder: (context, index) {
        return SoundItemWidget(identifier: identifiers[index]);
      },
    );
  }
}
