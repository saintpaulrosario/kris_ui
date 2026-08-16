import 'package:flutter/material.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/language.dart';
import 'package:kris/presentation/widget/content_wiget.dart';

import '../../model/identifier.dart';

import 'package:flutter/material.dart' show CircularProgressIndicator, Divider;
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

class ContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  @override
  void initState() {
    super.initState();

    final languages = context.read<LanguageBloc>().state.selections.toList();

    context.read<WordBloc>().add(
      BaseEvent.contents(identifiers: widget.identifiers, languages: languages),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload>
    >(
      listenWhen: (previous, current) =>
          previous.selections != current.selections,
      listener: (context, state) {
        final languages = state.selections.toList();

        context.read<WordBloc>().add(
          BaseEvent.contents(
            identifiers: widget.identifiers,
            languages: languages,
          ),
        );
      },
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
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.identifiers.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final identifier = widget.identifiers[index];
                  final content = state.contents[identifier.sku];

                  if (state.fetching.contains(identifier.sku)) {
                    return const CircularProgressIndicator();
                  }

                  if (content == null) {
                    return Text("content not found");
                  }

                  return Text(content.sku);
                },
              );
            },
          ),
    );
  }
}
