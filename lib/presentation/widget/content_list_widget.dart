import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'content_wiget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          itemCount: identifiers.length,
          itemBuilder: (_, index) {
            final identifier = identifiers.elementAt(index);
            return Text(identifier.sku);
          },
        ),
      ],
    );
  }
}
