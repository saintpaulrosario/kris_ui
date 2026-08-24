import 'package:flutter/material.dart';

import 'package:kris/model/identifier.dart';

import 'script_text_widget.dart';

class ScriptTextListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ScriptTextListWidget({super.key, required this.identifiers});

  @override
  State<ScriptTextListWidget> createState() => _ScriptTextListWidgetState();
}

class _ScriptTextListWidgetState extends State<ScriptTextListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.identifiers.isEmpty) {
      return const Text('No script texts');
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.identifiers.length,
      separatorBuilder: (_, _) {
        return const Divider(height: 1);
      },
      itemBuilder: (context, index) {
        final identifier = widget.identifiers[index];

        return ScriptTextWidget(
          key: ValueKey('script-text-${identifier.sku}'),
          identifier: identifier,
        );
      },
    );
  }
}
