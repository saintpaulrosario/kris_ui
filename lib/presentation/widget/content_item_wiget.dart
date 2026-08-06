import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/model/translation_content.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/dialect.dart';
import '../../model/identifier.dart';
import '../../model/language.dart';
import '../../model/translation.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import 'payload_list_widget.dart';

class ContentItemWidget extends StatefulWidget {
  final Identifier identifier;
  final String maya;

  const ContentItemWidget({
    super.key,
    required this.identifier,
    required this.maya,
  });

  @override
  State<ContentItemWidget> createState() => _ContentItemWidgetState();
}

class _ContentItemWidgetState extends State<ContentItemWidget> {
  @override
  void initState() {
    super.initState();
    if ("SCRIPT" == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.contentBySku(identifier: widget.identifier),
      );
    } else if ("LANGUAGE" == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.contentBySku(identifier: widget.identifier),
      );
    } else if ("DIALECT" == widget.maya) {
      context.read<DialectBloc>().add(
        BaseEvent.contentBySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.contentBySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maya == 'SCRIPT') {
      return BlocSelector<
        ScriptBloc,
        BaseState,
        ({bool fetching, TranslationContent? content})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.contents[widget.identifier.sku],
        ),
        builder: (context, state) {
          return _buildWidget(state);
        },
      );
    } else if (widget.maya == 'LANGUAGE') {
      return BlocSelector<
        LanguageBloc,
        BaseState<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, TranslationContent? content})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.contents[widget.identifier.sku],
        ),
        builder: (context, state) {
          return _buildWidget(state);
        },
      );
    } else if (widget.maya == 'DIALECT') {
      return BlocSelector<
        DialectBloc,
        BaseState<
          Dialect,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, TranslationContent? content})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.contents[widget.identifier.sku],
        ),
        builder: (context, state) {
          return _buildWidget(state);
        },
      );
    } else {
      return BlocSelector<
        TranslationBloc,
        BaseState<
          Translation,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, TranslationContent? content})
      >(
        selector: (state) => (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.contents[widget.identifier.sku],
        ),
        builder: (context, state) {
          return _buildWidget(state);
        },
      );
    }
  }

  Padding _buildWidget(({TranslationContent? content, bool fetching}) state) {
    if (state.fetching) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.content == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("script Content not found"),
      );
    }

    if (state.content!.payloads.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text("No payload found"),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PayloadListWidget(
              key: ValueKey('${state.content!.sku}_${widget.maya}'),
              identifiers: state.content!.payloads,
              maya: widget.maya,
            ),
          ),

          //const SizedBox(width: 12),
          //LanguageListWidget(identifiers: state.content!.languages),
        ],
      ),
    );
  }
}
