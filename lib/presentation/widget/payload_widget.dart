import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/language/language_list_widget.dart';
import 'package:kris/presentation/widget/language/language_widget.dart';
import 'package:kris/presentation/widget/translation_trait_list_widget.dart';

class PayloadWidget extends StatelessWidget {
  final Payload payload;

  const PayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // definition
        Expanded(
          flex: 45,
          child: TranslationTraitListWidget(identifiers: payload.traits),
        ),
        Expanded(
          flex: 4,
          child: Text(
            payload.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            key: ValueKey('value-${payload.sku}'),
          ),
        ),
        //Expanded(flex: 1, child: Text("data")),
      ],
    );
  }
}
