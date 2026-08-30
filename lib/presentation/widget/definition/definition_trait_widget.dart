import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/example_bloc.dart';
import 'package:kris/logic/word/example_state.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/model/example.dart';
import 'package:kris/presentation/screen/example/example_widget.dart';

import '../carousel_widget.dart';

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

    context.read<ExampleBloc>().add(
      BaseEvent.wordTrait(identifier: widget.trait),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExampleBloc, ExampleState, (bool fetching, Example?)>(
      selector: (state) {
        final fetching = state.fetching.contains(widget.trait.sku);

        final example = state.wordTraits[widget.trait.sku];

        return (fetching, example);
      },
      builder: (context, state) {
        final (fetching, example) = state;

        if (fetching) {
          return const CircularProgressIndicator();
        }

        if (example == null) {
          return const SizedBox.shrink();
        }

        return Text(example.toString());
        //return ExampleWidget(example: example);
      },
    );
  }
}
