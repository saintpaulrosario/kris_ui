import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/example.dart';
import 'package:kris/model/example_trait.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/screen/example/example_widget.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../../logic/word/example_bloc.dart' show ExampleBloc;
import '../../../model/content.dart';
import '../../../model/text.dart' as w;

class ExampleListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ExampleListWidget({super.key, required this.identifiers});

  @override
  State<ExampleListWidget> createState() => _ExampleListWidgetState();
}

class _ExampleListWidgetState extends State<ExampleListWidget> {
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
      BaseState<Example, w.Text, Content, Payload, ExampleTrait>,
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

        return CarouselWidget(items: items);
      },
    );
  }
}
