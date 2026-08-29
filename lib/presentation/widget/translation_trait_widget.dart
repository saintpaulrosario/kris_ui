import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/definition_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/translation_trait.dart';

class TranslationTraitWidget extends StatefulWidget {
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait});

  @override
  State<TranslationTraitWidget> createState() => _TranslationTraitWidgetState();
}

class _TranslationTraitWidgetState extends State<TranslationTraitWidget> {
  @override
  void initState() {
    super.initState();

    context.read<DefinitionBloc>().add(
      BaseEvent.wordTrait(identifier: widget.trait),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DefinitionBloc,
      DefinitionState,
      (BuiltSet<String> fetching, BuiltList<Definition> definitions)
    >(
      selector: (state) {
        final fetching = state.fetching.toBuilder();

        fetching.removeWhere((sku) => sku != widget.trait.sku);

        final definitions = state.wordTraitsDefinitions.toBuilder();

        definitions.removeWhere((sku, value) => sku != widget.trait.sku);

        return (
          fetching.build(),
          definitions[widget.trait.sku] ?? BuiltList<Definition>(),
        );
      },
      builder: (context, state) {
        final (fetching, definitions) = state;

        if (fetching.isNotEmpty) {
          return const CircularProgressIndicator();
        }

        if (definitions.isEmpty) {
          return const SizedBox.shrink();
        }

        return Row(children: [Text('${definitions.length} definitions')]);
      },
    );
  }
}
