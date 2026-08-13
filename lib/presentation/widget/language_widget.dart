import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/text_list_wiget.dart';
import 'package:kris/presentation/widget/text_widget.dart';

import '../../model/content.dart';
import '../../model/script.dart';
import 'package:kris/model/text.dart' as w;

class LanguageWidget extends StatefulWidget {
  final Identifier identifier;
  final Set<String> visited;

  const LanguageWidget({
    super.key,
    required this.identifier,
    required this.visited,
  });

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();

    if (!widget.visited.contains(widget.identifier.sku)) {
      context.read<LanguageBloc>().add(
        BaseEvent.bySku(identifier: widget.identifier),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.visited.contains(widget.identifier.sku)) {
      return const SizedBox.shrink();
    }

    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload>,
      ({bool fetching, Language? language})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          language: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching || state.language == null) {
          return const CircularProgressIndicator();
        }

        return TextListWidget(
          identifiers: state.language!.texts,
          visited: {...widget.visited, state.language!.sku},
        );
      },
    );
  }
}
