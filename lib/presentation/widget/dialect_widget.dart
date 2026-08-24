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

import 'dialect/dialect_widget.dart';

class DialectWidget extends StatefulWidget {
  final Identifier? identifier;

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
    if (widget.identifier != null) {
      context.read<DialectBloc>().add(
        BaseEvent.identifier(identifier: widget.identifier!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.identifier == null) {
      return SizedBox.shrink();
    }

    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload, Trait>,
      Dialect?
    >(
      selector: (state) {
        return state.data[widget.identifier!.sku];
      },
      builder: (context, dialect) {
        if (dialect == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return DialectTextListWidget(identifiers: dialect.texts);
      },
    );
  }
}
