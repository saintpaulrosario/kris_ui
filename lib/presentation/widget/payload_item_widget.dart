import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

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

    context.read<PayloadBloc>().add(
      PayloadEventRetrieveBySku(widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      PayloadBloc,
      PayloadState,
      ({bool fetching, Payload? payload})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          payload: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        final payload = state.payload;

        if (payload == null) {
          return const Text("Payload was not fetched");
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 3,
              child: WordListScreen(identifiers: payload.examples),
            ),

            Expanded(
              flex: 3,
              child: Text(payload.value, textAlign: TextAlign.center),
            ),

            Expanded(
              flex: 1,
              child: SoundListWidget(identifiers: payload.sounds),
            ),
          ],
        );
      },
    );
  }
}
