import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/definition_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/definition_trait.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../../model/text.dart' as w;
import 'definition_text_widget.dart';

class DefinitionTextListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const DefinitionTextListWidget({super.key, required this.identifiers});

  @override
  State<DefinitionTextListWidget> createState() =>
      _DefinitionTextListWidgetState();
}

class _DefinitionTextListWidgetState extends State<DefinitionTextListWidget> {
  @override
  void initState() {
    if (widget.identifiers.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _fetchTexts();
      });
    }
    super.initState();
  }

  void _fetchTexts() {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<DefinitionBloc>().add(
      BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DefinitionBloc,
      DefinitionState,
      BuiltMap<String, w.Text>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        final result = state.texts.toBuilder();

        // Keep only the requested identifiers.
        result.removeWhere((key, value) => !identifiers.contains(key));

        return result.build();
      },
      builder: (context, state) {
        List<DefinitionTextWidget> items = state.values
            .map((item) => DefinitionTextWidget(text: item))
            .toList();

        return CarouselWidget(items: items, autoPlay: true);
      },
    );
  }
}
