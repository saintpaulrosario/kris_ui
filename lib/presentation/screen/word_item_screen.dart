import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';
import 'package:kris/model/language.dart';

import '../../app_router.dart';
import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/identifier.dart';
import '../../model/script.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import '../widget/word_text_list_wiget.dart';

class WordItemScreen extends StatefulWidget {
  final Identifier identifier;
  final String maya;

  const WordItemScreen({
    super.key,
    required this.identifier,
    required this.maya,
  });

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String get sku => widget.identifier.sku;

  @override
  void initState() {
    super.initState();
    if ('SCRIPT' == widget.maya) {
      context.read<ScriptBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    }
    if ('LANGUAGE' == widget.maya) {
      context.read<LanguageBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    } else {
      context.read<TranslationBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if ('SCRIPT' == widget.maya) {
      return BlocSelector<
        ScriptBloc,
        BaseState<
          Script,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, List<Identifier> texts})
      >(
        selector: (state) {
          final word = state.data[sku];

          return (
            fetching: state.fetching.contains(sku),
            texts: word?.texts ?? const [],
          );
        },

        builder: (context, state) {
          if (state.fetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.texts.isEmpty) {
            return const Center(child: Text("Word not found"));
          }

          return _buildWidget(context, state);
        },
      );
    } else if ('SCRIPT' == widget.maya) {
      return BlocSelector<
        LanguageBloc,
        BaseState<
          Language,
          TranslationText,
          TranslationContent,
          TranslationPayload
        >,
        ({bool fetching, List<Identifier> texts})
      >(
        selector: (state) {
          final word = state.data[sku];

          return (
            fetching: state.fetching.contains(sku),
            texts: word?.texts ?? const [],
          );
        },

        builder: (context, state) {
          if (state.fetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.texts.isEmpty) {
            return const Center(child: Text("Word not found"));
          }

          return _buildWidget(context, state);
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
        ({bool fetching, List<Identifier> texts})
      >(
        selector: (state) {
          final word = state.data[sku];

          return (
            fetching: state.fetching.contains(sku),
            texts: word?.texts ?? const [],
          );
        },

        builder: (context, state) {
          if (state.fetching) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.texts.isEmpty) {
            return const Center(child: Text("Word not found"));
          }

          return _buildWidget(context, state);
        },
      );
    }
  }

  Card _buildWidget(
    BuildContext context,
    ({bool fetching, List<Identifier> texts}) state,
  ) {
    return Card(
      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: () {
          context.pushNamed(routeWordDetail, pathParameters: {'sku': sku});
        },

        child: Padding(
          padding: const EdgeInsets.all(8),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Expanded(
                flex: 4,

                child: WordTextListWidget(
                  key: ValueKey('${sku}_texts'),
                  identifiers: state.texts,
                  maya: widget.maya,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
