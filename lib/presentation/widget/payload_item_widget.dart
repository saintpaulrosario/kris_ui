import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/payload/bloc/payload_bloc.dart';
import '../../model/identifier.dart';
import '../../model/payload.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'sound_list_wiget.dart';

class PayloadItemWidget extends StatefulWidget {
  final Identifier identifier;
  const PayloadItemWidget({super.key, required this.identifier});

  @override
  State<PayloadItemWidget> createState() => _PayloadItemWidgetState();
}

class _PayloadItemWidgetState extends State<PayloadItemWidget> {
  @override
  initState() {
    context.read<PayloadBloc>().add(
      PayloadEventRetrieveBySku(widget.identifier.sku),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PayloadBloc, PayloadState, PayloadState>(
      selector: (state) {
        return state;
      },
      builder: (context, state) {
        if (state.fetching.contains(widget.identifier.sku)) {
          return const Center(child: CircularProgressIndicator());
        } else if (!state.payloads.containsKey(widget.identifier.sku)) {
          return const Center(child: Text("Payload not found"));
        }
        return BlocSelector<PayloadBloc, PayloadState, Payload>(
          selector: (state) {
            return state.payloads[widget.identifier.sku]!;
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("example")],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(state.value)],
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [SoundListWidget(identifiers: state.sounds)],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
