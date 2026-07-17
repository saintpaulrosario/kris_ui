import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/example_payload/bloc/example_payload_bloc.dart';

import '../../logic/payload/bloc/payload_bloc.dart';
import '../../model/payload.dart';
import '../../model/identifier.dart';
import '../screen/word_list_screen.dart';
import 'sound_list_wiget.dart';

class PayloadItemWidget extends StatefulWidget {
  final Identifier identifier;

  const PayloadItemWidget({super.key, required this.identifier});

  @override
  State<PayloadItemWidget> createState() => _PayloadItemWidgetState();
}

class _PayloadItemWidgetState extends State<PayloadItemWidget> {
  @override
  void initState() {
    super.initState();

    if ('EXAMPLE' == widget.identifier.type) {
      context.read<ExamplePayloadBloc>().add(
        ExamplePayloadEventRetriveByIdentifier(identifier: widget.identifier),
      );
    } else {
      context.read<PayloadBloc>().add(
        PayloadEventRetrieveBySku(widget.identifier),
      );
    }
  }

  Widget _buildPayload(Payload? payload, bool fetching) {
    if (fetching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (payload == null) {
      return const Text("Payload was not fetched");
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 7,
          child: WordListScreen(
            identifiers: payload.examples,
            key: Key(payload.sku),
          ),
        ),

        Expanded(
          flex: 3,
          child: Text(payload.value, textAlign: TextAlign.center),
        ),

        Expanded(
          flex: 1,
          child: SoundListWidget(
            identifiers: payload.sounds,
            key: Key(payload.sku),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifier.type == "EXAMPLE") {
      return BlocSelector<
        ExamplePayloadBloc,
        ExamplePayloadState,
        ({bool fetching, Payload? payload})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          payload: state.data[widget.identifier.sku],
        ),

        builder: (context, state) {
          return _buildPayload(state.payload, state.fetching);
        },
      );
    }

    return BlocSelector<
      PayloadBloc,
      PayloadState,
      ({bool fetching, Payload? payload})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        payload: state.data[widget.identifier.sku],
      ),

      builder: (context, state) {
        return _buildPayload(state.payload, state.fetching);
      },
    );
  }
}
