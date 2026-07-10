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
        return Card(child: PayloadItemWidget(identifier: identifier));
      },
    );
  }
}
