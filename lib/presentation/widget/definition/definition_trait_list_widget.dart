import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/definition_trait.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/definition/definition_trait_widget.dart';

import '../../../model/content.dart';
import '../../../model/text.dart' as w;

class DefinitionTraitListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const DefinitionTraitListWidget({super.key, required this.identifiers});

  @override
  State<DefinitionTraitListWidget> createState() =>
      _DefinitionTraitListWidgetState();
}

class _DefinitionTraitListWidgetState extends State<DefinitionTraitListWidget> {
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

    context.read<DefinitionBloc>().add(
      BaseEvent.traits(identifiers: widget.identifiers, dialects: dialects),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifiers.isEmpty) {
      return SizedBox.shrink();
    }

    return BlocSelector<
      DefinitionBloc,
      BaseState<Definition, w.Text, Content, Payload, DefinitionTrait>,
      BuiltMap<String, DefinitionTrait>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        return state.traits.rebuild((builder) {
          builder.removeWhere((key, value) => !identifiers.contains(key));
        });
      },
      builder: (context, contents) {
        if (contents.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: contents.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final trait = contents.values.elementAt(index);
            return DefinitionTraitWidget(
              key: ValueKey(trait.sku),
              trait: trait,
            );
          },
        );
      },
    );
  }
}
