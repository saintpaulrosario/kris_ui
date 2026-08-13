import 'package:flutter/material.dart';
import 'package:kris/presentation/widget/script/script_text_widget.dart';

import '../../../model/identifier.dart';

class ScriptTextListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptTextListWidget({super.key, required this.identifiers});

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
            return ScriptTextWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
