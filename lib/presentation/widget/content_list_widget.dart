import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import 'content_item_wiget.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  State<ContentListWidget> createState() => _ImageListWidgetState();
}

class _ImageListWidgetState extends State<ContentListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.identifiers.length,
        itemBuilder: (context, index) {
          Identifier identifier = widget.identifiers[index];
          return ContentItemWidget(identifier: identifier);
        },
      ),
    );
  }
}
