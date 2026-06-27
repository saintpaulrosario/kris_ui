import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';

import '../../model/content.dart';

class ContentItemWidget extends StatelessWidget {
  final Content content;
  const ContentItemWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(content.payload)],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [SoundListWidget(sounds: content.sounds)],
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("definition")],
            ),
          ],
        ),
      ),
    );
  }
}
