import 'package:flutter/material.dart' show Divider, CircularProgressIndicator;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/identifier.dart';

import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/language/language_content_list_widget.dart';

import '../../../logic/base_event.dart';

class LanguageTextWidget extends StatefulWidget {
  final Identifier identifier;

  const LanguageTextWidget({super.key, required this.identifier});

  @override
  State<LanguageTextWidget> createState() => _LanguageTextWidgetState();
}

class _LanguageTextWidgetState extends State<LanguageTextWidget> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(
      BaseEvent.textBySku(identifier: widget.identifier, scripts: {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LanguageBloc,
      BaseState,
      ({bool fetching, w.Text? text})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          text: state.texts[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final text = state.text;

        if (text == null) {
          return const SizedBox.shrink();
        }

        return LanguageContentListWidget(identifiers: state.text!.contents);
      },
    );
  }
}
