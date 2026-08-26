import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/example_bloc.dart';
import 'package:kris/model/example.dart';
import 'package:kris/model/example_trait.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';
import 'package:kris/presentation/widget/example/example_trait_widget.dart';

import '../../../model/content.dart';
import '../../../model/text.dart' as w;

class ExampleTraitListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ExampleTraitListWidget({super.key, required this.identifiers});

  @override
  State<ExampleTraitListWidget> createState() => _ExampleTraitListWidgetState();
}

class _ExampleTraitListWidgetState extends State<ExampleTraitListWidget> {
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
    final dialects = context.read<DialectBloc>().state.selections.toList();

    context.read<ExampleBloc>().add(
      BaseEvent.traits(identifiers: widget.identifiers, dialects: dialects),
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
      BuiltMap<String, ExampleTrait>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        return state.traits.rebuild((builder) {
          builder.removeWhere((key, value) => !identifiers.contains(key));
        });
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        List<ExampleTraitWidget> items = state.values
            .map((trait) => ExampleTraitWidget(trait: trait))
            .toList();

        return CarouselWidget(items: items);
      },
    );
  }
}
