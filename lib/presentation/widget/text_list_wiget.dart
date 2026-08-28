import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../model/text.dart' as w;
import 'text_widget.dart';

class TextListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const TextListWidget({super.key, required this.identifiers});

  @override
  State<TextListWidget> createState() => _TextListWidgetState();
}

class _TextListWidgetState extends State<TextListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _fetchTexts();
    });
  }

  void _fetchTexts() {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<WordBloc>().add(
      BaseEvent.texts(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      WordBloc,
      BaseState<Word, w.Text, Content, Payload, Trait>,
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
        List<TextWidget> items = state.values
            .map((text) => TextWidget(text: text))
            .toList();

        return CarouselWidget(items: items, autoPlay: true);
      },
    );
  }
}
