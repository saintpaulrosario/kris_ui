import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/example_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/example.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/presentation/screen/example/example_widget.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../../model/content.dart';
import '../../../model/text.dart' as w;

class DefinitionListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const DefinitionListWidget({super.key, required this.identifiers});

  @override
  State<DefinitionListWidget> createState() => _DefinitionListWidgetState();
}

class _DefinitionListWidgetState extends State<DefinitionListWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.identifiers.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        _fetchContents();
      });
    }
  }

  void _fetchContents() {
    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<ExampleBloc>().add(
      BaseEvent.fetch(identifiers: widget.identifiers, scripts: scripts),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifiers.isEmpty) {
      return SizedBox.shrink();
    }

    return BlocSelector<
      ExampleBloc,
      BaseState<Example, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Example>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        return state.data.rebuild((builder) {
          builder.removeWhere((key, value) => !identifiers.contains(key));
        });
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        List<ExampleWidget> items = state.values
            .map((definition) => ExampleWidget(example: definition))
            .toList();

        return Text(state.toString());
        //return CarouselWidget(items: items);
      },
    );
  }
}
