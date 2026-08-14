import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';

import '../../../logic/base_event.dart';
import '../../../logic/base_state.dart';
import '../../../model/content.dart';
import '../../../model/identifier.dart';
import 'package:kris/model/text.dart' as w;

class DialectPayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectPayloadWidget({super.key, required this.identifier});

  @override
  State<DialectPayloadWidget> createState() => _DialectPayloadWidgetState();
}

class _DialectPayloadWidgetState extends State<DialectPayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<DialectBloc>().add(
      BaseEvent.payloadBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload>,
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

        if (state.payload == null) {
          return const Text("Payload was not fetched");
        }

        return Expanded(
          child: Text(
            state.payload!.value,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            key: ValueKey(state.payload!.sku),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
