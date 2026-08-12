import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:kris/model/text.dart' as m;

class TextListWidget extends StatelessWidget {
  final List<m.Text> texts;

  const TextListWidget({super.key, required this.texts});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ListView.separated(
        itemCount: texts.length,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Text(texts[index].sku);
        },
      ),
    );
  }
}
