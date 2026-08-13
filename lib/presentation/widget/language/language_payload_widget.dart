import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/presentation/widget/sound_list_wiget.dart';
import 'package:kris/presentation/widget/word_widget.dart';

import '../../../logic/base_event.dart';
import '../../../logic/base_state.dart';
import '../../../model/content.dart';
import '../../../model/identifier.dart';
import 'package:kris/model/text.dart' as w;

class LanguagePayloadWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguagePayloadWidget({super.key, required this.identifier});

  @override
  State<LanguagePayloadWidget> createState() => _LanguagePayloadWidgetState();
}

class _LanguagePayloadWidgetState extends State<LanguagePayloadWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(
      BaseEvent.payloadBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload>,
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
