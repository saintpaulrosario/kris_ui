import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';

import 'package:kris/model/content.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/text.dart' as w;

import 'dialect_payload_list_widget.dart';

class DialectContentWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectContentWidget({super.key, required this.identifier});

  @override
  State<DialectContentWidget> createState() => _DialectContentWidgetState();
}

class _DialectContentWidgetState extends State<DialectContentWidget>
    with AutomaticKeepAliveClientMixin {
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
      BaseState<Dialect, w.Text, Content, Payload>,
      Content?
    >(
      selector: (state) {
        return state.contents[widget.identifier.sku];
      },
      builder: (context, content) {
        if (content == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (content.payloads.isEmpty) {
          return const SizedBox.shrink();
        }

        return DialectPayloadListWidget(identifiers: content.payloads);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
