import 'package:flutter/material.dart';
import 'package:kris/model/definition_trait.dart';

class ExampleTraitWidget extends StatelessWidget {
  final DefinitionTrait trait;

  const ExampleTraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Expanded(flex: 3, child: Text("example"))],
    );
  }
}
