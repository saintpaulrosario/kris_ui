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

import 'dialect_content_list_widget.dart';

class DialectTextWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectTextWidget({super.key, required this.identifier});

  @override
  State<DialectTextWidget> createState() => _DialectTextWidgetState();
}

class _DialectTextWidgetState extends State<DialectTextWidget> {
  @override
  void initState() {
    super.initState();

    context.read<DialectBloc>().add(
      BaseEvent.text(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload>,
      w.Text?
    >(
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return DialectContentListWidget(identifiers: text.contents);
      },
    );
  }
}
