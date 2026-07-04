import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'payload_item_widget.dart';

class PayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  const PayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: identifiers.length,
      itemBuilder: (context, index) {
        final identifier = identifiers[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [PayloadItemWidget(identifier: identifier)],
            ),
          ),
        );
      },
    );
  }
}
