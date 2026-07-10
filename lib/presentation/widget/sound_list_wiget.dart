import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'sound_item_wiget.dart';

class SoundListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: identifiers.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 4);
      },
      itemBuilder: (context, index) {
        return SoundItemWidget(identifier: identifiers[index]);
      },
    );
  }
}
