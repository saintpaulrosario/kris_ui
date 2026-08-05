import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/logic/script/bloc/script_bloc.dart';

import 'package:kris/logic/translation/bloc/translation_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/word_text_list_wiget.dart';

import '../../logic/base_event.dart';
import '../../logic/language/bloc/language_bloc.dart';
import '../../model/language.dart';
import 'script_text_list_widget.dart';

class LanguageWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguageWidget({super.key, required this.identifier});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(
      BaseEvent.bySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LanguageBloc,
      LanguageState,
      ({bool fetching, Language? word})
    >(
      selector: (state) => (
        fetching: state.fetching.contains(widget.identifier.sku),
        word: state.data[widget.identifier.sku],
      ),
      builder: (context, state) {
        if (state.fetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.word == null) {
          return const Center(child: Text("script not found"));
        }

        return Card(
          key: ValueKey(widget.identifier.sku),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ScriptTextListWidget(
                  key: ValueKey('${state.word!.sku}_texts'),
                  identifiers: state.word!.texts,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
