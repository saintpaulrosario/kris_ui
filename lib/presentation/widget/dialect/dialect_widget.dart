import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/base_state.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/presentation/widget/dialect/dialect_text_list_widget.dart';

import '../../../model/content.dart';
import 'package:kris/model/text.dart' as w;

class DialectWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectWidget({super.key, required this.identifier});

  @override
  State<DialectWidget> createState() => _DialectWidgetState();
}

class _DialectWidgetState extends State<DialectWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    context.read<DialectBloc>().add(
      BaseEvent.identifier(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload>,
      ({bool fetching, Dialect? dialect})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          dialect: state.data[widget.identifier.sku],
        );
      },
      builder: (context, state) {
        if (state.fetching || state.dialect == null) {
          return const CircularProgressIndicator();
        }

        return DialectTextListWidget(identifiers: state.dialect!.texts);
      },
    );
  }
}
