import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/language/language_payload_list_widget.dart';

class LanguageContentWidget extends StatefulWidget {
  final Identifier identifier;
  const LanguageContentWidget({super.key, required this.identifier});

  @override
  State<LanguageContentWidget> createState() => _LanguageContentWidgetState();
}

class _LanguageContentWidgetState extends State<LanguageContentWidget> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(
      BaseEvent.contentBySku(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LanguageBloc,
      BaseState,
      ({bool fetching, Content? content})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          content: state.contents[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching) {
          return CircularProgressIndicator();
        }
        if (state.content == null) {
          return Text("no content");
        }

        return LanguagePayloadListWidget(identifiers: state.content!.payloads);
      },
    );
  }
}
