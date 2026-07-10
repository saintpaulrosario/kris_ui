import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'payload_item_widget.dart';

class PayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const PayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    if (identifiers.isEmpty) {
      return const Text("No payload found");
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: identifiers.length,
      separatorBuilder: (context, index) {
        return const Divider(height: 1);
      },
      itemBuilder: (context, index) {
        return Card(child: PayloadItemWidget(identifier: identifiers[index]));
      },
    );
  }
}
