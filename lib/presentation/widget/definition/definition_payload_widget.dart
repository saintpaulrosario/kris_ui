import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/definition/definition_trait_list_widget.dart';
import 'package:kris/presentation/widget/audio_list_wiget.dart';
import 'package:kris/presentation/widget/dialect/dialect_list_widget.dart';

class DefinitionPayloadWidget extends StatelessWidget {
  final Payload payload;

  const DefinitionPayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 12,
          child: DefinitionTraitListWidget(identifiers: payload.traits),
        ),
        Flexible(
          flex: 1,
          child: SoundListWidget(
            key: ValueKey('sound-${payload.sku}'),
            identifiers: payload.audios,
          ),
        ),
        Flexible(
          flex: 5,
          child: Text(
            payload.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            key: ValueKey('value-${payload.sku}'),
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
