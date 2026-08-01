import 'package:flutter/widgets.dart';

import '../../model/identifier.dart';

class ScriptWidget extends StatefulWidget {
  final Identifier identifier;
  const ScriptWidget({super.key, required this.identifier});

  @override
  State<ScriptWidget> createState() => _ScriptWidgetState();
}

class _ScriptWidgetState extends State<ScriptWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
