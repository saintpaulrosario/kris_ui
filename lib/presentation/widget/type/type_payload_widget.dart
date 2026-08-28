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
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/audio_list_wiget.dart';

import '../../../logic/word/word_bloc.dart';

class TypePayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const TypePayloadWidget({super.key, required this.identifier});

  @override
  State<TypePayloadWidget> createState() => _TypePayloadWidgetState();
}

class _TypePayloadWidgetState extends State<TypePayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<WordBloc>().add(
      BaseEvent.payload(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      WordBloc,
      BaseState<Word, w.Text, Content, Payload, Trait>,
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
