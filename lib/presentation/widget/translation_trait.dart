import 'package:flutter/material.dart';
import 'package:kris/model/translation_trait.dart';

import 'package:kris/presentation/widget/trait_widget.dart';

class TranslationTraitWidget extends TraitWidget {
  @override
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait})
    : super(trait: trait);

  @override
  Widget build(BuildContext context) {
    return Flexible(child: super.build(context));
  }
}
