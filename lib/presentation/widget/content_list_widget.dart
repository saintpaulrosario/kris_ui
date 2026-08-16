import 'package:flutter/material.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/language.dart';
import 'package:kris/presentation/widget/content_wiget.dart';

import '../../model/identifier.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/word.dart';

import '../../model/text.dart' as w;
import 'text_widget.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  void _fetchContents(BuildContext context) {
    final languages = context.read<LanguageBloc>().state.selections.toList();
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<WordBloc>().add(
      BaseEvent.contents(
        identifiers: widget.identifiers,
        languages: languages,
        scripts: scripts,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchContents(context);
    // Initial fetch
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScriptBloc, BaseState<Script, w.Text, Content, Payload>>(
          listenWhen: (previous, current) =>
              previous.selections != current.selections,
          listener: (context, state) {
            _fetchContents(context);
          },
        ),
        BlocListener<
          LanguageBloc,
          BaseState<Language, w.Text, Content, Payload>
        >(
          listenWhen: (previous, current) =>
              previous.selections != current.selections,
          listener: (context, state) {
            _fetchContents(context);
          },
        ),
      ],
      child:
          BlocSelector<
            WordBloc,
            BaseState<Word, w.Text, Content, Payload>,
            ({Set<String> fetching, Map<String, Content> contents})
          >(
            selector: (state) {
              final identifiers = widget.identifiers.map((x) => x.sku).toSet();

              return (
                fetching: state.fetching.where(identifiers.contains).toSet(),

                contents: Map.fromEntries(
                  state.contents.entries.where(
                    (entry) => identifiers.contains(entry.key),
                  ),
                ),
              );
            },
            builder: (context, state) {
              if (state.contents.isEmpty) {
                return Text("no content");
              }
              return Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.contents.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final content = state.contents.values.elementAt(index);

                      if (state.fetching.contains(content.sku)) {
                        return const CircularProgressIndicator();
                      }

                      return Text("hbkbkjb");
                    },
                  ),
                ],
              );
            },
          ),
    );
  }
}
