import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/dialect/dialect_list_widget.dart';
import 'package:kris/presentation/widget/translation_trait_list_widget.dart';
import 'package:kris/presentation/widget/audio_list_wiget.dart';
import 'package:kris/presentation/widget/trait_list_widget.dart';

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
          flex: 12,
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
      ],
    );
  }
}
