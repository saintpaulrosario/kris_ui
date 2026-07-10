import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'content_item_wiget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: identifiers.length,
        itemBuilder: (context, index) {
          Identifier identifier = identifiers[index];
          return ContentItemWidget(identifier: identifier);
        },
      ),
    );
  }
}
