import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'sound_item_wiget.dart';

class SoundListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const SoundListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Center(child: Icon(Icons.volume_off));
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: identifiers.length,
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
      itemBuilder: (context, index) {
        final identifier = identifiers[index];

        return SoundItemWidget(
          key: ValueKey(identifier.sku),
          identifier: identifier,
        );
      },
    );
  }
}
