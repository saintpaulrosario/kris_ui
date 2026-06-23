import 'package:flutter/material.dart';
import 'package:kris/model/identifier.dart';

import '../../model/word.dart';
import '../screen/word_item_screen.dart';
import 'word_text_item_widget.dart';

class WordTextListWidget extends StatelessWidget {
  final List<Identifier> textsIdentifiers;

  const WordTextListWidget({super.key, required this.textsIdentifiers});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: textsIdentifiers
            .map(
              (textIdentifier) =>
                  WordTextItemWidget(textIdentifier: textIdentifier),
            )
            .toList(),
      ),
    );

    // return SingleChildScrollView(
    //   child: Card(
    //     color: Colors.green,
    //     child: ListView.separated(
    //       shrinkWrap: true,
    //       physics: NeverScrollableScrollPhysics(),
    //       clipBehavior: Clip.hardEdge,
    //       separatorBuilder: (context, index) {
    //         return const Divider(height: 1.0);
    //       },
    //       itemCount: texts.length,
    //       itemBuilder: (context, index) {
    //         var text = texts[index];
    //         return Card(
    //           color: Colors.yellow,
    //           child: WordTextItemWidget(textIdentifier: text),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
