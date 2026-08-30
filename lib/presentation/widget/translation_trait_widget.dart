import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/translation_trait.dart';
import 'package:kris/presentation/widget/definition/defintion_list_widget.dart';

import '../../model/text.dart' as w;

class TranslationTraitWidget extends StatefulWidget {
  final TranslationTrait trait;

  const TranslationTraitWidget({super.key, required this.trait});

  @override
  State<TranslationTraitWidget> createState() => _TranslationTraitWidgetState();
}

class _TranslationTraitWidgetState extends State<TranslationTraitWidget> {
  @override
  void initState() {
    super.initState();

    context.read<TranslationBloc>().add(
      BaseEvent.wordTrait(identifier: widget.trait),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      TranslationBloc,
      BaseState<Translation, w.Text, Content, Payload, TranslationTrait>,
      (bool fetching, Translation?)
    >(
      selector: (state) {
        final fetching = state.fetching.contains(widget.trait.sku);

        final translation = state.wordTraits[widget.trait.sku];

        return (fetching, translation);
      },
      builder: (context, state) {
        final (fetching, translation) = state;

        if (fetching) {
          return const CircularProgressIndicator();
        }

        if (translation == null) {
          return const SizedBox.shrink();
        }

        return DefinitionListWidget(identifiers: [?translation.definition]);
      },
    );
  }
}
