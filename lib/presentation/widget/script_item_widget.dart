import 'package:flutter/material.dart';

import '../../model/script.dart';

class ScriptItemWidget extends StatelessWidget {
  final Script script;

  const ScriptItemWidget({super.key, required this.script});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: script.contents!.map((content) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(value: true, onChanged: (value) {}),
            Flexible(fit: FlexFit.loose, child: Text(content.payload ?? '')),
          ],
        );
      }).toList(),
    );
  }
}
