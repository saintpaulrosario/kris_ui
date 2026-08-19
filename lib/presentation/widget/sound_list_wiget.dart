import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/sound_wiget.dart';

import '../../model/identifier.dart';

class SoundListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Icon(Icons.volume_off);
    }

    return ListView.separated(
      separatorBuilder: ((context, index) => Divider()),
      itemCount: identifiers.length,
      itemBuilder: (context, index) {
        return SoundWidget(identifier: identifiers.elementAt(index));
      },
    );
  }
}
