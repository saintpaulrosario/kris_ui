import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/content.dart';

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
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.contents
            .map((content) => ListTile(title: Text(content.payload)))
            .toList(),
      ),
    );
  }
}
