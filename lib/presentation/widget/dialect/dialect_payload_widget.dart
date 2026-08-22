import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/trait.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';

class DialectPayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectPayloadWidget({super.key, required this.identifier});

  @override
  State<DialectPayloadWidget> createState() => _DialectPayloadWidgetState();
}

class _DialectPayloadWidgetState extends State<DialectPayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<DialectBloc>().add(
      BaseEvent.payload(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload, Trait>,
      Payload?
    >(
      selector: (state) {
        return state.payloads[widget.identifier.sku];
      },
      builder: (context, payload) {
        if (payload == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final List<Identifier> audios = payload.audios.isEmpty
            ? []
            : [payload.audios.first];

        return Row(
          children: [
            SoundListWidget(identifiers: audios),
            Text(
              payload.value,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              key: ValueKey(payload.sku),
            ),
          ],
        );
      },
    );
  }
}
