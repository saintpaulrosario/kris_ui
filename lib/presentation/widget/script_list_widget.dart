import 'package:flutter/material.dart';

import '../../model/identifier.dart';
import 'script_wiget.dart';

class ScriptListWidget extends StatelessWidget {
  final List<Identifier> identifiers;

  const ScriptListWidget({super.key, required this.identifiers});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 300,

      child: identifiers.isEmpty
          ? const Center(child: Text("No scripts found"))
          : ListView.builder(
              padding: EdgeInsets.zero,

              itemCount: identifiers.length,

              itemBuilder: (context, index) {
                return SizedBox(
                  width: 350,

                  child: ScriptWidget(identifier: identifiers[index]),
                );
              },
            ),
    );
  }
}
