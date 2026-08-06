import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import '../../logic/base_event.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/translation_payload.dart';
import 'sound_list_wiget.dart';

class PayloadItemWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;

  const PayloadItemWidget({
    super.key,
    required this.identifier,
    required this.maya,
  });

  @override
  State<PayloadItemWidget> createState() => _PayloadItemWidgetState();
}

class _PayloadItemWidgetState extends State<PayloadItemWidget> {
  @override
  void initState() {
    super.initState();
    if ('SCRIPT' == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    } else if ('LANGUAGE' == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    } else if ('DIALECT' == widget.maya) {
      context.read<DialectBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.payloadBySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if ('SCRIPT' == widget.maya) {
      return BlocSelector<
        ScriptBloc,
        ScriptState,
        ({bool fetching, TranslationPayload? payload})
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
              Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                key: ValueKey('${state.payload!.sku}_${widget.maya}'),
              ),
            ],
          );
        },
      );
    } else if (widget.maya == 'LANGUAGE') {
      return BlocSelector<
        LanguageBloc,
        LanguageState,
        ({bool fetching, TranslationPayload? payload})
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
              Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                key: ValueKey('${state.payload!.sku}_${widget.maya}'),
              ),
            ],
          );
        },
      );
    } else if (widget.maya == 'DIALECT') {
      return BlocSelector<
        DialectBloc,
        DialectState,
        ({bool fetching, TranslationPayload? payload})
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
              Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                key: ValueKey('${state.payload!.sku}_${widget.maya}'),
              ),
            ],
          );
        },
      );
    } else {
      return BlocSelector<
        TranslationBloc,
        TranslationState,
        ({bool fetching, TranslationPayload? payload})
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
              Text(
                state.payload!.value,
                textAlign: TextAlign.center,
                key: ValueKey('${state.payload!.sku}_${widget.maya}'),
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
}
