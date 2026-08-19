import 'package:flutter/material.dart';

import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/dialect/dialect_list_widget.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';

class PayloadWidget extends StatelessWidget {
  final Payload payload;

  const PayloadWidget({super.key, required this.payload});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SoundListWidget(
            key: ValueKey('sound-${payload.sku}'),
            identifiers: payload.sounds,
          ),
        ),
        Expanded(
          child: Text(
            payload.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            key: ValueKey('value-${payload.sku}'),
          ),
        ),

        Expanded(
          child: DialectListWidget(
            key: ValueKey('dialect-${payload.sku}'),
            identifiers: payload.dialects,
          ),
        ),
      ],
    );
  }
}
