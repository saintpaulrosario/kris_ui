import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/audio_list_wiget.dart';
import 'package:kris/presentation/widget/example/example_trait_list_widget.dart';

class ExamplePayloadWidget extends StatelessWidget {
  final Payload payload;

  const ExamplePayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: ExampleTraitListWidget(identifiers: payload.traits)),
        Expanded(
          flex: 1,
          child: SoundListWidget(
            key: ValueKey('sound-${payload.sku}'),
            identifiers: payload.audios,
          ),
        ),
        Expanded(
          flex: 3,
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
