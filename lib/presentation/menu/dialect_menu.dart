import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/dialect.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/trait.dart';

import '../../logic/base_state.dart';
import '../../model/content.dart';
import '../../model/payload.dart';
import '../../model/script.dart';
import '../page/menu_widget.dart';

class DialectMenu extends StatefulWidget {
  const DialectMenu({super.key});

  @override
  State<DialectMenu> createState() => _DialectMenuState();
}

class _DialectMenuState extends State<DialectMenu> {
  @override
  void initState() {
    super.initState();

    context.read<DialectBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      DialectBloc,
      BaseState<Dialect, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Dialect>
    >(
      // This widget now only listens to data.
      //
      // Selecting an item changes `selections`, not `data`,
      // so this selector will NOT rebuild because of selection changes.
      selector: (state) => state.data,
      builder: (context, data) {
        return _DialectMenuSelection(words: data.values.toList());
      },
    );
  }
}

class _DialectMenuSelection extends StatelessWidget {
  final List<Dialect> words;

  const _DialectMenuSelection({required this.words});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload, Trait>,
      BuiltSet<Identifier>
    >(
      // This widget only listens to selections.
      selector: (state) => state.selections,
      builder: (context, selections) {
        return MenuWidget(
          key: const ValueKey('script-menu'),
          maya: 'DIALECT',
          label: 'dialect',
          words: words,
          selections: selections.toSet(),
          onSelectionChanged: (identifier, selected) {
            context.read<DialectBloc>().add(
              BaseEvent.select(identifier: identifier, selected: selected),
            );
          },
        );
      },
    );
  }
}
