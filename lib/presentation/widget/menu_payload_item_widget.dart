import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';

class MenuPayloadItemWidget extends StatefulWidget {
  final Identifier identifier;
  const MenuPayloadItemWidget({super.key, required this.identifier});

  @override
  State<MenuPayloadItemWidget> createState() => _MenuPayloadItemWidgetState();
}

class _MenuPayloadItemWidgetState extends State<MenuPayloadItemWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PayloadBloc, PayloadState, Map<String, Payload>>(
      selector: (state) {
        return state.payloads;
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return Text("payloads not available");
        } else if (state.containsKey(widget.identifier.sku)) {
          return Text("paylod not found");
        } else {
          return BlocSelector<PayloadBloc, PayloadState, Payload>(
            selector: (state) {
              return state.payloads[widget.identifier.sku]!;
            },
            builder: (context, state) {
              return Text(state.value);
            },
          );
        }
      },
    );
  }
}
