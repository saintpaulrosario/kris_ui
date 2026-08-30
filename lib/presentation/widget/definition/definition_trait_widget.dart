import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/presentation/widget/example/example_list_widget.dart';

import '../../../logic/base_state.dart';
import '../../../model/content.dart';
import '../../../model/definition.dart';
import '../../../model/payload.dart';
import '../../../model/text.dart' as w;

class DefinitionTraitWidget extends StatefulWidget {
  final DefinitionTrait trait;

  const DefinitionTraitWidget({super.key, required this.trait});

  @override
  State<DefinitionTraitWidget> createState() => _DefinitionTraitWidgetState();
}

class _DefinitionTraitWidgetState extends State<DefinitionTraitWidget> {
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
      BaseState<Definition, w.Text, Content, Payload, DefinitionTrait>,
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

        return ExampleListWidget(identifiers: [definition.example]);
      },
    );
  }
}
