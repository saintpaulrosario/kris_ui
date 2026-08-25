import 'package:flutter/material.dart';
import 'package:kris/model/example.dart';

import 'example_text_list_widget.dart';

class ExampleWidget extends StatelessWidget {
  final Example example;

  const ExampleWidget({super.key, required this.example});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(example.sku),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("data"),
          // Expanded(
          //   flex: 7,
          //   child: ExampleTextListWidget(
          //     key: ValueKey('${example.sku}-texts'),
          //     identifiers: example.texts,
          //   ),
          // ),
        ],
      ),
    );
  }
}
