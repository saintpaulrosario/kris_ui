import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:kris/model/identifier.dart';

import 'text_widget.dart';

class TextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;
  final Set<String> visited;

  const TextListWidget({
    super.key,
    required this.identifiers,
    required this.visited,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: identifiers.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final identifier = identifiers.elementAt(index);
            return TextWidget(identifier: identifier, visited: visited);
          },
        ),
      ],
    );
  }
}
