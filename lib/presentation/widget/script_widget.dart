import 'package:flutter/material.dart';

import '../../model/script.dart';
import 'script_item_widget.dart';

class ScriptWidget extends StatelessWidget {
  final List<Script> scripts;

  const ScriptWidget({super.key, required this.scripts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: scripts.map((script) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ScriptItemWidget(script: script),
          );
        }).toList(),
      ),
    );
  }
}
