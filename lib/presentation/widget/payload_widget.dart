import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/dialect/dialect_list_widget.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../model/content.dart';
import '../../model/dialect.dart';
import '../../model/identifier.dart';
import '../../model/translation.dart';
import 'package:kris/model/text.dart' as w;

class PayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const PayloadWidget({super.key, required this.identifier});

  @override
  State<PayloadWidget> createState() => _PayloadWidgetState();
}

class _PayloadWidgetState extends State<PayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    final dialects = context.read<DialectBloc>().state.selections.toSet();

    context.read<TranslationBloc>().add(
      BaseEvent.payloadBySku(identifier: widget.identifier, dialects: dialects),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocListener<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) =>
          previous.selections != current.selections,

      listener: (context, state) {
        context.read<TranslationBloc>().add(
          BaseEvent.payloadBySku(
            identifier: widget.identifier,
            dialects: state.selections.toSet(),
          ),
        );
      },

      child:
          BlocSelector<
            TranslationBloc,
            BaseState<Translation, w.Text, Content, Payload>,
            ({bool fetching, Payload? payload})
          >(
            selector: (state) => (
              fetching: state.fetching.contains(widget.identifier.sku),
              payload: state.payloads[widget.identifier.sku],
            ),

            builder: (context, state) {
              if (state.fetching) {
                return const Center(child: CircularProgressIndicator());
              }

              final payload = state.payload;

              if (payload == null) {
                return const Text('Payload was not fetched');
              }

              return Row(
                children: [
                  Expanded(child: SoundListWidget(identifiers: payload.sounds)),

                  Expanded(
                    child: Text(
                      payload.value,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      key: ValueKey(payload.sku),
                    ),
                  ),

                  Expanded(
                    child: DialectListWidget(identifiers: payload.dialects),
                  ),
                ],
              );
            },
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
