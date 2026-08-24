import 'package:flutter/material.dart';

import 'package:kris/model/content.dart';

import 'example_payload_list_widget.dart';

class ExampleContentWidget extends StatelessWidget {
  final Content content;

  const ExampleContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 5,
          child: ExamplePayloadListWidget(
            key: ValueKey(content.sku),
            identifiers: content.payloads,
          ),
        ),
      ],
    );
  }
}
