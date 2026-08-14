import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/payload_widget.dart';

import '../../model/identifier.dart';

class PayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const PayloadListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, _) => Divider(),
          itemCount: identifiers.length,
          itemBuilder: (_, index) {
            final identifier = identifiers.elementAt(index);
            return PayloadWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
