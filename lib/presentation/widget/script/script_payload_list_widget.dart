import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/script/script_payload_widget.dart';

import 'script_content_widget.dart';

class ScriptPayloadListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptPayloadListWidget({super.key, required this.identifiers});

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
            return ScriptPayloadWidget(identifier: identifier);
          },
        ),
      ],
    );
  }
}
