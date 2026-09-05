import 'package:flutter/material.dart';

import 'package:kris/model/content.dart';

import 'payload_list_widget.dart';

class ContentWidget extends StatelessWidget {
  final Content content;

  const ContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
  
    return PayloadListWidget(
      key: ValueKey(content.sku),
      identifiers: content.payloads,
    );
  }
}
