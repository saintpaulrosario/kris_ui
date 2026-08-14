import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/content_wiget.dart';

import '../../model/identifier.dart';

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
          separatorBuilder: (_, _) => Divider(),
          itemCount: identifiers.length,
          itemBuilder: (_, index) {
            final identifier = identifiers.elementAt(index);
            return ContentWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
