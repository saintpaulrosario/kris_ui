import 'package:flutter/material.dart';

import 'package:kris/model/content.dart';

import 'definition_payload_list_widget.dart';

class DefinitionContentWidget extends StatelessWidget {
  final Content content;

  const DefinitionContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return DefinitionPayloadListWidget(
      key: ValueKey(content.sku),
      identifiers: content.payloads,
    );
  }
}
