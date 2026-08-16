import 'package:flutter/material.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/payload_widget.dart';

import '../../model/identifier.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';

import '../../model/text.dart' as w;

class PayloadListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const PayloadListWidget({super.key, required this.identifiers});

  @override
  State<PayloadListWidget> createState() => _PayloadListWidgetState();
}

class _PayloadListWidgetState extends State<PayloadListWidget> {
  void _fetchPayloads(BuildContext context) {
    final scripts = context.read<ScriptBloc>().state.selections.toList();
    final languages = context.read<LanguageBloc>().state.selections.toList();
    final dialects = context.read<DialectBloc>().state.selections.toList();

    context.read<WordBloc>().add(
      BaseEvent.payloads(
        identifiers: widget.identifiers,
        languages: languages,
        scripts: scripts,
        dialects: dialects,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchPayloads(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ScriptBloc, BaseState<Script, w.Text, Content, Payload>>(
          listenWhen: (previous, current) =>
              previous.selections != current.selections,
          listener: (context, state) {
            _fetchPayloads(context);
          },
        ),
        BlocListener<
          LanguageBloc,
          BaseState<Language, w.Text, Content, Payload>
        >(
          listenWhen: (previous, current) =>
              previous.selections != current.selections,
          listener: (context, state) {
            _fetchPayloads(context);
          },
        ),

        BlocListener<DialectBloc, BaseState<Dialect, w.Text, Content, Payload>>(
          listenWhen: (previous, current) =>
              previous.selections != current.selections,
          listener: (context, state) {
            _fetchPayloads(context);
          },
        ),
      ],
      child:
          BlocSelector<
            WordBloc,
            BaseState<Word, w.Text, Content, Payload>,
            ({Set<String> fetching, Map<String, Payload> payloads})
          >(
            selector: (state) {
              final identifiers = widget.identifiers.map((x) => x.sku).toSet();

              return (
                fetching: state.fetching.where(identifiers.contains).toSet(),

                payloads: Map.fromEntries(
                  state.payloads.entries.where(
                    (entry) => identifiers.contains(entry.key),
                  ),
                ),
              );
            },
            builder: (context, state) {
              if (state.payloads.isEmpty) {
                return Text("no content");
              }
              return Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.payloads.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final Payload payload = state.payloads.values.elementAt(
                        index,
                      );

                      if (state.fetching.contains(payload.sku)) {
                        return const CircularProgressIndicator();
                      }

                      return PayloadWidget(payload: payload);
                    },
                  ),
                ],
              );
            },
          ),
    );
  }
}
