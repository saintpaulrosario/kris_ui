import 'package:flutter/material.dart' show CircularProgressIndicator, Divider;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';

import '../../model/text.dart' as w;
import 'text_widget.dart';

class TextListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const TextListWidget({super.key, required this.identifiers});

  @override
  State<TextListWidget> createState() => _TextListWidgetState();
}

class _TextListWidgetState extends State<TextListWidget> {
  void _fetchContents(BuildContext context) {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<WordBloc>().add(
      BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchContents(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) =>
          previous.selections != current.selections,
      listener: (context, state) {
        _fetchContents(context);
      },
      child:
          BlocSelector<
            WordBloc,
            BaseState<Word, w.Text, Content, Payload>,
            ({Set<String> fetching, Map<String, w.Text> texts})
          >(
            selector: (state) {
              final identifiers = widget.identifiers.map((x) => x.sku).toSet();

              return (
                fetching: state.fetching.where(identifiers.contains).toSet(),

                texts: Map.fromEntries(
                  state.texts.entries.where(
                    (entry) => identifiers.contains(entry.key),
                  ),
                ),
              );
            },
            builder: (context, state) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.texts.values.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final text = state.texts.values.elementAt(index);

                  if (state.fetching.contains(text.sku)) {
                    return const CircularProgressIndicator();
                  }

                  return TextWidget(text: text);
                },
              );
            },
          ),
    );
  }
}
