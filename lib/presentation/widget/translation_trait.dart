import 'package:flutter/material.dart';

import 'package:kris/presentation/widget/definition/defintion_list_widget.dart';

import '../../model/trait.dart';

class TranslationTraitWidget extends StatelessWidget {
  final Trait trait;

  const TranslationTraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: DefinitionListWidget(identifiers: trait.definitions),
        ),
        Expanded(flex: 3, child: Text("example")),
      ],
    );
  }
}
