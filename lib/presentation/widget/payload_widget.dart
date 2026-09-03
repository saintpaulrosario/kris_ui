import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/dialect/dialect_list_widget.dart';
import 'package:kris/presentation/widget/translation_trait_list_widget.dart';
import 'package:kris/presentation/widget/type/type_list_widget.dart';

class PayloadWidget extends StatelessWidget {
  final Payload payload;

  const PayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 15,
          child: Row(
            children: [
              Flexible(
                child: TranslationTraitListWidget(identifiers: payload.traits),
              ),
              Flexible(
                child: Text(
                  payload.value,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  key: ValueKey('value-${payload.sku}'),
                ),
              ),
              Flexible(child: TypeListWidget(identifiers: payload.types)),
            ],
          ),
        ),

        Flexible(
          flex: 5,
          child: DialectListWidget(identifiers: payload.dialects),
        ),
      ],
    );
  }
}
