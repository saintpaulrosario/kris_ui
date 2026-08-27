import 'package:flutter/material.dart';
import 'package:kris/model/translation.dart';

import 'image_list_widget.dart';
import 'text_list_wiget.dart';

class WordWidget extends StatelessWidget {
  final Translation translation;

  const WordWidget({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 10,
          child: ImageListWidget(
            key: ValueKey('${translation.sku}-images'),
            identifiers: translation.images,
          ),
        ),
        Flexible(
          flex: 40,
          child: TextListWidget(
            key: ValueKey('${translation.sku}-texts'),
            identifiers: translation.texts,
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.bookmark)),
        ),
      ],
    );
  }
}
