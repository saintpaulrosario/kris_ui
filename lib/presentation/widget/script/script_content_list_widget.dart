import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:kris/model/identifier.dart';

import 'script_content_widget.dart';

class ScriptContentListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptContentListWidget({super.key, required this.identifiers});

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
            return ScriptContentWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
