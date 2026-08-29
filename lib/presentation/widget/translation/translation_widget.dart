import 'package:flutter/material.dart';
import 'package:kris/model/translation.dart';

import '../text_list_wiget.dart';

class TranslationWidget extends StatelessWidget {
  final Translation translation;
  const TranslationWidget({super.key, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 57,
            child: TextListWidget(
              key: ValueKey('${translation.sku}-texts'),
              identifiers: translation.texts,
            ),
          ),
          Flexible(flex: 3, child: Text("Translation")),
        ],
      ),
    );
  }
}
