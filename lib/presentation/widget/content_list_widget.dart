import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/identifier.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> contentsIdentifiers;

  const ContentListWidget({super.key, required this.contentsIdentifiers});

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
        children: widget.contentsIdentifiers
            .map((content) => ListTile(title: Text(content.sku)))
            .toList(),
      ),
    );
  }
}
