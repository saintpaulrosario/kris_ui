import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/language/language_list_widget.dart';
import 'package:kris/presentation/widget/language/language_widget.dart';
import 'package:kris/presentation/widget/translation_trait_list_widget.dart';

import '../../model/language.dart';

class PayloadWidget extends StatelessWidget {
  final Payload payload;

  const PayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    final languages = payload.language != null
        ? [payload.language!]
        : <Language>[];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // definition
        Flexible(
          flex: 20,
          child: TranslationTraitListWidget(identifiers: payload.traits),
        ),
        Flexible(
          flex: 4,
          child: Text(
            payload.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            key: ValueKey('value-${payload.sku}'),
          ),
        ),
        Flexible(flex: 2, child: LanguageListWidget(identifiers: languages)),
      ],
    );
  }
}
