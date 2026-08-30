import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/definition_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/translation_trait.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';
import 'package:kris/presentation/widget/definition/definition_widget.dart';

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
      (bool fetching, Definition?)
    >(
      selector: (state) {
        final fetching = state.fetching.contains(widget.trait.sku);

        final definition = state.wordTraits[widget.trait.sku];

        return (fetching, definition);
      },
      builder: (context, state) {
        final (fetching, definition) = state;

        if (fetching) {
          return const CircularProgressIndicator();
        }

        if (definition == null) {
          return const SizedBox.shrink();
        }

        return DefinitionWidget(definition: definition);
      },
    );
  }
}
