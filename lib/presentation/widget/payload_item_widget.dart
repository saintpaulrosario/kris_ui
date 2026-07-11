import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/widget/example_list_widget.dart';

import '../../logic/payload/bloc/payload_bloc.dart';
import '../../model/identifier.dart';
import '../../model/payload.dart';
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
        } else if (state.payload == null) {
          context.read<PayloadBloc>().add(
            PayloadEventRetrieveBySku(widget.identifier.sku),
          );
          return const Text("Payload was not fetched");
        } else {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 3, child: Text("example")),

              Expanded(
                flex: 3,
                child: Text(state.payload!.value, textAlign: TextAlign.end),
              ),

              Expanded(
                flex: 1,
                child: SoundListWidget(identifiers: state.payload!.sounds),
              ),
            ],
          );
        }
      },
    );
  }
}
