import 'package:built_collection/built_collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/base_event.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/model/language.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/model/trait.dart';

import '../../logic/base_state.dart';
import '../../model/content.dart';
import '../../model/payload.dart';
import '../../model/script.dart';
import '../page/menu_widget.dart';

class LanguageMenu extends StatefulWidget {
  const LanguageMenu({super.key});

  @override
  State<LanguageMenu> createState() => _LanguageMenuState();
}

class _LanguageMenuState extends State<LanguageMenu> {
  @override
  void initState() {
    super.initState();

    context.read<LanguageBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      BuiltMap<String, Language>
    >(
      // This widget now only listens to data.
      //
      // Selecting an item changes `selections`, not `data`,
      // so this selector will NOT rebuild because of selection changes.
      selector: (state) => state.data,
      builder: (context, data) {
        return _LanguageMenuSelection(words: data.values.toList());
      },
    );
  }
}

class _LanguageMenuSelection extends StatelessWidget {
  final List<Language> words;

  const _LanguageMenuSelection({required this.words});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LanguageBloc,
      BaseState<Language, w.Text, Content, Payload, Trait>,
      BuiltSet<Identifier>
    >(
      // This widget only listens to selections.
      selector: (state) => state.selections,
      builder: (context, selections) {
        return MenuWidget(
          key: const ValueKey('language-menu'),
          maya: 'LANGUAGE',
          label: 'language',
          words: words,
          selections: selections.toSet(),
          onSelectionChanged: (identifier, selected) {
            context.read<LanguageBloc>().add(
              BaseEvent.select(identifier: identifier, selected: selected),
            );
          },
        );
      },
    );
  }
}
