import 'package:flutter/material.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/presentation/widget/dialect_widget.dart';
import 'package:kris/presentation/widget/example/example_list_widget.dart';
import 'package:kris/presentation/widget/trait_widget.dart';

class DefinitionTraitWidget extends TraitWidget {
  final DefinitionTrait trait;

  const DefinitionTraitWidget({super.key, required this.trait})
    : super(trait: trait);

  @override
  Widget build(BuildContext context) {
    return ExampleListWidget(identifiers: trait.examples);
  }
}
