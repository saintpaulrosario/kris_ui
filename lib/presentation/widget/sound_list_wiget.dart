import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'sound_item_wiget.dart';

class SoundListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Icon(Icons.volume_off);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final identifier in identifiers)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text("sound"),
          ),
      ],
    );
  }
}
