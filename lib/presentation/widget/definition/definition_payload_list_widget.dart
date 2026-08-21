import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/word.dart';

import '../../../model/text.dart' as w;
import 'definition_payload_widget.dart';

class DefinitionPayloadListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const DefinitionPayloadListWidget({super.key, required this.identifiers});

  @override
  State<DefinitionPayloadListWidget> createState() =>
      _DefinitionPayloadListWidgetState();
}

class _DefinitionPayloadListWidgetState
    extends State<DefinitionPayloadListWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.identifiers.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _fetchPayloads();
      });
    }
  }

  void _fetchPayloads() {
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
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      BaseState<Word, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Payload>
    >(
      selector: (state) {
        final identifiers = widget.identifiers.map((e) => e.sku).toSet();

        final result = state.payloads.toBuilder();

        result.removeWhere((key, value) => !identifiers.contains(key));

        return result.build();
      },
      builder: (context, payloads) {
        if (payloads.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: payloads.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final payload = payloads.values.elementAt(index);

            return DefinitionPayloadWidget(
              key: ValueKey(payload.sku),
              payload: payload,
            );
          },
        );
      },
    );
  }
}
