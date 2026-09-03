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
          flex: 60,
          child: Row(
            children: [
              Flexible(
                flex: 55,
                child: Row(
                  children: [
                    Flexible(
                      flex: 50,
                      child: TranslationTraitListWidget(
                        identifiers: payload.traits,
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Text(
                        softWrap: true,
                        payload.value,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        key: ValueKey('value-${payload.sku}'),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 5,
                child: TypeListWidget(identifiers: payload.types),
              ),
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
