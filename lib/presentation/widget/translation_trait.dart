import 'package:flutter/material.dart';
import 'package:kris/model/translation_trait.dart';

import 'package:kris/presentation/widget/definition/defintion_list_widget.dart';
import 'package:kris/presentation/widget/trait_widget.dart';

import 'dialect_widget.dart';

class TranslationTraitWidget extends TraitWidget {
  @override
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait})
    : super(trait: trait);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          flex: 7,
          child: DefinitionListWidget(identifiers: trait.definitions),
        ),
        Flexible(flex: 1, child: super.build(context)),
      ],
    );
  }
}
