import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/dialect_widget.dart';

import '../../../model/identifier.dart';

class TypeListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const TypeListWidget({super.key, required this.identifiers});

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
