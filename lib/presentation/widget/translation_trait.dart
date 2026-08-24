import 'package:flutter/material.dart';
import 'package:kris/model/translation_trait.dart';

import 'package:kris/presentation/widget/definition/defintion_list_widget.dart';

class TranslationTraitWidget extends StatelessWidget {
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: DefinitionListWidget(identifiers: trait.definitions)),
      ],
    );
  }
}
