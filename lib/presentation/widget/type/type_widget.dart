import 'package:flutter/material.dart';
import 'package:kris/model/type.dart' as w;
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/dialect/dialect_text_widget.dart';

import '../../../model/identifier.dart';

import 'package:kris/model/translation.dart';

import '../text_list_wiget.dart';

class TypeWidget extends StatelessWidget {
  final w.Type type;
  const TypeWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 55,
            child: TextListWidget(
              key: ValueKey('${type.sku}-texts'),
              identifiers: type.texts,
            ),
          ),
        ],
      ),
    );
  }
}
