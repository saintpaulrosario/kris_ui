import 'package:flutter/material.dart';
import 'package:kris/model/translation_trait.dart';

import 'package:kris/presentation/widget/definition/defintion_list_widget.dart';
import 'package:kris/presentation/widget/trait_widget.dart';

class TranslationTraitWidget extends TraitWidget {
  @override
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait})
    : super(trait: trait);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 12,
          child: DefinitionListWidget(identifiers: trait.definitions),
        ),
        Expanded(flex: 1, child: super.build(context)),
      ],
    );
  }
}
