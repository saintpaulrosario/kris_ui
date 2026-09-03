import 'package:flutter/material.dart';

import 'package:kris/model/text.dart' as w;

import 'definition_content_list_widget.dart';

class DefinitionTextWidget extends StatelessWidget {
  final w.Text text;

  const DefinitionTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DefinitionContentListWidget(identifiers: text.contents);
  }
}
