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
    //return Text(widget.contentsIdentifiers.first.sku);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.contents
          .map((content) => ContentItemWidget(content: content))
          .toList(),
    );
  }
}
