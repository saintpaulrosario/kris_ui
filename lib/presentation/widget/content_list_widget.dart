import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/word.dart';
import 'package:kris/presentation/widget/carousel_widget.dart';

import '../../model/text.dart' as w;
import 'content_wiget.dart';

class ContentListWidget extends StatefulWidget {
  final List<Identifier> identifiers;

  const ContentListWidget({super.key, required this.identifiers});

  @override
  State<ContentListWidget> createState() => _ContentListWidgetState();
}

class _ContentListWidgetState extends State<ContentListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _fetchContents();
    });
  }

  void _fetchContents() {
    final languages = context.read<LanguageBloc>().state.selections.toList();

    final scripts = context.read<ScriptBloc>().state.selections.toList();

    context.read<WordBloc>().add(
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
      WordBloc,
      BaseState<Word, w.Text, Content, Payload, Trait>,
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
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (content, index) {
            return Flexible(
              child: ContentWidget(content: state.values.elementAt(index)),
            );
          },
          separatorBuilder: (_, __) => Divider(),
          itemCount: state.length,
        );
      },
    );
  }
}
