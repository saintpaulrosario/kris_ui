import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/widget/dialect/dialect_payload_list_widget.dart';

class DialectContentWidget extends StatefulWidget {
  final Identifier identifier;
  const DialectContentWidget({super.key, required this.identifier});

  @override
  State<DialectContentWidget> createState() => _DialectContentWidgetState();
}

class _DialectContentWidgetState extends State<DialectContentWidget> {
  @override
  void initState() {
    super.initState();
    context.read<DialectBloc>().add(
      BaseEvent.content(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DialectBloc,
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

        return DialectPayloadListWidget(identifiers: state.content!.payloads);
      },
    );
  }
}
