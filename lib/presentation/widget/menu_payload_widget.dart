import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';

import '../../logic/payload/bloc/payload_bloc.dart';

class MenuPayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const MenuPayloadWidget({super.key, required this.identifier});

  @override
  State<MenuPayloadWidget> createState() => _MenuPayloadWidgetState();
}

class _MenuPayloadWidgetState extends State<MenuPayloadWidget> {
  @override
  void initState() {
    super.initState();

    context.read<PayloadBloc>().add(
      PayloadEventRetrieveBySku(widget.identifier.sku),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PayloadBloc, PayloadState, Payload?>(
      selector: (state) => state.payloads[widget.identifier.sku],

      builder: (context, payload) {
        if (payload == null) {
          return const SizedBox();
        }

        return Text(payload.value);
      },
    );
  }
}
