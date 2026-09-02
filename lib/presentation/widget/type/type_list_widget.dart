import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/type_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/type.dart' as w;

import '../../../model/text.dart' as w;
import '../carousel_widget.dart';
import 'type_widget.dart';

class TypeListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const TypeListWidget({super.key, required this.identifiers});

  @override
  State<TypeListWidget> createState() => _TypeListWidgetState();
}

class _TypeListWidgetState extends State<TypeListWidget> {
  @override
  void initState() {
    if (widget.identifiers.isNotEmpty) {
      _fetchPayloads();
    }

    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (!mounted) return;

    //   _fetchPayloads();
    // });
  }

  void _fetchPayloads() {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    final languages = context.read<LanguageBloc>().state.selections.toList();

    final dialects = context.read<DialectBloc>().state.selections.toList();

    context.read<TypeBloc>().add(
      BaseEvent.fetch(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifiers.isEmpty) {
      return SizedBox.shrink();
    }
    return BlocSelector<
      TypeBloc,
      BaseState<w.Type, w.Text, Content, Payload, Trait>,
      BuiltMap<String, w.Type>
    >(
      selector: (state) {
        final identifiers = widget.identifiers.map((e) => e.sku).toSet();

        final result = state.data.toBuilder();

        result.removeWhere((key, value) => !identifiers.contains(key));

        return result.build();
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        List<TypeWidget> items = state.values
            .map((type) => TypeWidget(type: type))
            .toList();

        return CarouselWidget(items: items, autoPlay: true);
      },
    );
  }
}
