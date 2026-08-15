import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/script.dart';
import 'package:kris/presentation/widget/content_list_widget.dart';

import 'script/script_widget.dart';

class TextWidget extends StatefulWidget {
  final Identifier identifier;

  const TextWidget({super.key, required this.identifier});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    final scripts = context.read<ScriptBloc>().state.selections.toSet();

    context.read<TranslationBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) =>
          previous.selections != current.selections,

      listener: (context, state) {
        context.read<TranslationBloc>().add(
          BaseEvent.textBySku(
            identifier: widget.identifier,
            scripts: state.selections.toSet(),
          ),
        );
      },

      child:
          BlocSelector<
            TranslationBloc,
            BaseState<Translation, w.Text, Content, Payload>,
            ({bool fetching, w.Text? text})
          >(
            selector: (state) {
              return (
                fetching: state.fetching.contains(widget.identifier.sku),
                text: state.texts[widget.identifier.sku],
              );
            },
            builder: (context, state) {
              if (state.fetching) {
                return const SizedBox(
                  height: 40,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final text = state.text;

              if (text == null) {
                return const SizedBox.shrink();
              }

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ContentListWidget(identifiers: text.contents),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ScriptWidget(
                          key: ValueKey(text.script.sku),
                          identifier: text.script,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
