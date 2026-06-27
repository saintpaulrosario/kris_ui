import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/content.dart';
import 'content_item_wiget.dart';

class ContentListWidget extends StatefulWidget {
  final List<Content> contents;

  const ContentListWidget({super.key, required this.contents});

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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.contents.length,
      itemBuilder: (context, index) {
        Content content = widget.contents[index];
        return ContentItemWidget(content: content);
      },
    );
  }
}
