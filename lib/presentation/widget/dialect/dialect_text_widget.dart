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
import 'package:kris/model/trait.dart';
import 'package:kris/presentation/widget/dialect/dialect_content_widget.dart';

import 'dialect_content_list_widget.dart';

class DialectTextWidget extends StatefulWidget {
  final Identifier identifier;

  const DialectTextWidget({super.key, required this.identifier});

  @override
  State<DialectTextWidget> createState() => _DialectTextWidgetState();
}

class _DialectTextWidgetState extends State<DialectTextWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    context.read<DialectBloc>().add(
      BaseEvent.text(identifier: widget.identifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload, Trait>,
      w.Text?
    >(
      selector: (state) {
        return state.texts[widget.identifier.sku];
      },
      builder: (context, text) {
        if (text == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return DialectContentWidget(identifier: text.contents.first);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
