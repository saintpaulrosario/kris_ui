import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';

import '../../../model/text.dart' as w;
import 'definition_text_widget.dart';

class DefinitionTextListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const DefinitionTextListWidget({super.key, required this.identifiers});

  @override
  State<DefinitionTextListWidget> createState() =>
      _DefinitionTextListWidgetState();
}

class _DefinitionTextListWidgetState extends State<DefinitionTextListWidget> {
  @override
  void initState() {
    super.initState();

    if (widget.identifiers.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _fetchTexts();
      });
    }
  }

  void _fetchTexts() {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<DefinitionBloc>().add(
      BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DefinitionBloc,
      BaseState<Definition, w.Text, Content, Payload, DefinitionTrait>,
      BuiltMap<String, w.Text>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        final result = state.texts.toBuilder();

        // Keep only the requested identifiers.
        result.removeWhere((key, value) => !identifiers.contains(key));

        return result.build();
      },
      builder: (context, texts) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: texts.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final text = texts.values.elementAt(index);

            return DefinitionTextWidget(key: ValueKey(text.sku), text: text);
          },
        );
      },
    );
  }
}
