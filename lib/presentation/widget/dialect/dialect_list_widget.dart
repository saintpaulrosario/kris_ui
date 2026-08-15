import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/dialect/dialect_widget.dart';

import '../../../model/identifier.dart';

class DialectListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const DialectListWidget({super.key, required this.identifiers});

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
            return DialectWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
