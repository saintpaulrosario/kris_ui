import 'package:flutter/material.dart' show Divider;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    Set<String> scripts = context.read<ScriptBloc>().state.selections.toSet();
    context.read<TranslationBloc>().add(
      BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) {
        return previous.selections != current.selections;
      },
      listener: (context, state) {
        Set<String> scripts = context
            .read<ScriptBloc>()
            .state
            .selections
            .toSet();
        context.read<WordBloc>().add(
          BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
        );
      },
      child:
          BlocSelector<
            WordBloc,
            BaseState<Word, w.Text, Content, Payload>,
            ({Set<bool> fetching, Set<w.Text>? texts})
          >(
            selector: (state) {
              return (
                fetching: {
                  
                },
                texts: state.texts.entries
                    .where(
                      (x) => widget.identifiers
                          .map((i) => i.sku)
                          .toSet()
                          .contains(x.key),
                    )
                    .map((x) => x.value)
                    .toSet(),
              );
            },
            builder: (context, state) {
              if (state.texts!.isEmpty) {
                return Text("texts empty");
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.texts!.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final text = state.texts!.elementAt(index);
                      return TextWidget(text: text);
                    },
                  ),
                ],
              );
            },
          ),
    );
  }
}
