import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/text.dart' as w;

import '../../logic/base_state.dart';
import '../../model/content.dart';
import '../../model/payload.dart';
import '../../model/script.dart';
import '../page/menu_widget.dart';

class ScriptMenu extends StatefulWidget {
  const ScriptMenu({super.key});

  @override
  State<ScriptMenu> createState() => _ScriptMenuState();
}

class _ScriptMenuState extends State<ScriptMenu> {
  @override
  void initState() {
    super.initState();

    context.read<ScriptBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      BuiltMap<String, Script>
    >(
      // This widget now only listens to data.
      //
      // Selecting an item changes `selections`, not `data`,
      // so this selector will NOT rebuild because of selection changes.
      selector: (state) => state.data,
      builder: (context, data) {
        return _ScriptMenuSelection(words: data.values.toList());
      },
    );
  }
}

class _ScriptMenuSelection extends StatelessWidget {
  final List<Script> words;

  const _ScriptMenuSelection({required this.words});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      ScriptBloc,
      BaseState<Script, w.Text, Content, Payload>,
      BuiltSet<Identifier>
    >(
      // This widget only listens to selections.
      selector: (state) => state.selections,
      builder: (context, selections) {
        return MenuWidget(
          key: const ValueKey('script-menu'),
          maya: 'SCRIPT',
          label: 'script',
          words: words,
          selections: selections.toSet(),
          onSelectionChanged: (identifier, selected) {
            context.read<ScriptBloc>().add(
              BaseEvent.select(identifier: identifier, selected: selected),
            );
          },
        );
      },
    );
  }
}
