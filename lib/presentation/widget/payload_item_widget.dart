import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/identifier.dart';
import '../../model/word_payload.dart';
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
    context.read<WordBloc>().add(
      RetrieveWordsEventFetchPayloadBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      WordState,
      ({bool fetching, WordPayload? payload})
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

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 6,
              child: Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                key: Key(state.payload!.sku),
              ),
            ),

            // Expanded(
            //   flex: 2,
            //   child: SoundListWidget(
            //     identifiers: state.payload.sounds,
            //     key: Key(state.payload.sku),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
