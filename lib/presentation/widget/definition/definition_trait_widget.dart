import 'package:flutter/material.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/presentation/widget/example/example_list_widget.dart';

class DefinitionTraitWidget extends StatelessWidget {
  final DefinitionTrait trait;

  const DefinitionTraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: ExampleListWidget(identifiers: trait.examples),
        ),
      ],
    );
  }
}
