import 'package:flutter/material.dart';

import 'package:kris/model/content.dart';

import 'language/language_list_widget.dart';
import 'payload_list_widget.dart';

class ContentWidget extends StatelessWidget {
  final Content content;

  const ContentWidget({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 9,
          child: PayloadListWidget(
            key: ValueKey(content.sku),
            identifiers: content.payloads,
          ),
        ),
        Expanded(
          flex: 1,
          child: LanguageListWidget(
            key: ValueKey(content.sku),
            identifiers: content.languages,
          ),
        ),
      ],
    );
  }
}
