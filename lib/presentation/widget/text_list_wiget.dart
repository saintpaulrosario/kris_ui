import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:kris/model/identifier.dart';

import 'text_widget.dart';

class TextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const TextListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: identifiers.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final identifier = identifiers.elementAt(index);
          return TextWidget(identifier: identifier, visited: {});
        },
      ),
    );
  }
}
