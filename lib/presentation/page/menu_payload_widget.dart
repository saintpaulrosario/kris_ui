import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/script_payload.dart';
import 'package:kris/model/translation_payload.dart';

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

    context.read<ScriptBloc>().add(
      BaseEvent.payloadBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScriptBloc, ScriptState, ScriptPayload?>(
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
