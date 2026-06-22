import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/identifier.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> contents;

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
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: widget.contents.length,
      itemBuilder: (context, index) {
        final content = widget.contents[index];
        return Text(content.sku);
      },
    );
  }
}
