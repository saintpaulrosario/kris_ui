import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'content_item_wiget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No content found");
    }

    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: identifiers.length,
        separatorBuilder: (context, index) {
          return const Divider(height: 1);
        },
        itemBuilder: (context, index) {
          return ContentItemWidget(identifier: identifiers[index]);
        },
      ),
    );
  }
}
