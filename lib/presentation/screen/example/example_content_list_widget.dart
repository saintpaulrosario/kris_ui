import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/definition.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/presentation/widget/definition/definition_payload_list_widget.dart';

import '../../../model/text.dart' as w;
import 'example_content_widget.dart';

class ExampleContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ExampleContentListWidget({super.key, required this.identifiers});

  @override
  State<ExampleContentListWidget> createState() =>
      _ExampleContentListWidgetState();
}

class _ExampleContentListWidgetState extends State<ExampleContentListWidget> {
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
    final languages = context.read<LanguageBloc>().state.selections.toList();

    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<DefinitionBloc>().add(
      BaseEvent.contents(
        identifiers: widget.identifiers,
        languages: languages,
        scripts: scripts,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DefinitionBloc,
      BaseState<Definition, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Content>
    >(
      selector: (state) {
        final identifiers = widget.identifiers
            .map((identifier) => identifier.sku)
            .toSet();

        return state.contents.rebuild((builder) {
          builder.removeWhere((key, value) => !identifiers.contains(key));
        });
      },
      builder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final content = state.values.elementAt(index);

            return ExampleContentWidget(
              key: ValueKey(content.sku),
              content: content,
            );
          },
        );
      },
    );
  }
}
