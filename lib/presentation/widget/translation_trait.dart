import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/model/translation_trait.dart';

import 'package:kris/presentation/widget/trait_widget.dart';

import '../../logic/base_state.dart';
import '../../model/content.dart';
import '../../model/payload.dart';
import '../../model/text.dart' as w;

class TranslationTraitWidget extends TraitWidget {
  @override
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait})
    : super(trait: trait);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DefinitionBloc,

      BaseState<Definition, w.Text, Content, Payload, DefinitionTrait>,
      BuiltMap<String, DefinitionTrait>
    >(
      selector: (state) {
        return state.traits.rebuild((builder) {
          builder.removeWhere((key, value) => trait.sku != value);
        });
      },
      builder: (context, state) {
        return Row(
          children: [
            Text("definition"),
            Flexible(child: super.build(context)),
          ],
        );
      },
    );
  }
}
