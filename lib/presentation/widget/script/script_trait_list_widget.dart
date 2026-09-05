import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/content.dart';

import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/script.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/trait.dart';
import 'package:kris/presentation/widget/trait_widget.dart';

class ScriptTraitListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ScriptTraitListWidget({super.key, required this.identifiers});

  @override
  State<ScriptTraitListWidget> createState() => _ScriptTraitListWidgetState();
}

class _ScriptTraitListWidgetState extends State<ScriptTraitListWidget> {
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

    context.read<ScriptBloc>().add(
      BaseEvent.traits(identifiers: widget.identifiers, dialects: dialects),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.identifiers.isEmpty) {
      return SizedBox.shrink();
    }

    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Trait>
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

            return TraitWidget(key: ValueKey(trait.sku), trait: trait);
          },
        );
      },
    );
  }
}
