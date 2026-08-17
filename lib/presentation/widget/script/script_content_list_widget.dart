import 'package:flutter/material.dart';

import 'package:kris/model/identifier.dart';

import 'script_content_widget.dart';

class ScriptContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ScriptContentListWidget({super.key, required this.identifiers});

  @override
  State<ScriptContentListWidget> createState() =>
      _ScriptContentListWidgetState();
}

class _ScriptContentListWidgetState extends State<ScriptContentListWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.identifiers.isEmpty) {
      return const Text('No contents');
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

        return ScriptContentWidget(
          key: ValueKey('script-content-${identifier.sku}'),
          identifier: identifier,
        );
      },
    );
  }
}
