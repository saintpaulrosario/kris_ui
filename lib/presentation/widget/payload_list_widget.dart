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
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../model/text.dart' as w;
import 'language/language_list_widget.dart';
import 'payload_widget.dart';

class PayloadListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const PayloadListWidget({super.key, required this.identifiers});

  @override
  State<PayloadListWidget> createState() => _PayloadListWidgetState();
}

class _PayloadListWidgetState extends State<PayloadListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _fetchPayloads();
    });
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
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => Divider(),
          itemCount: state.length,
          itemBuilder: (_, index) {
            Payload payload = state.values.elementAt(index);
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LanguageListWidget(identifiers: [?payload.language]),
                  ),
                ),
                Flexible(flex: 20, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PayloadWidget(payload: payload),
                )),
              ],
            );
          },
        );
      },
    );
  }
}
