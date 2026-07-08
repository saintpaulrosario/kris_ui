import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/dialect/dialect.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/language/language.dart';
import 'package:kris/presentation/widget/menu_list_wiget.dart';

import '../../logic/script/bloc/script_bloc.dart';
import '../../model/script.dart';
import '../../model/word.dart';
import 'dialect_menu_wiget.dart';
import 'language_menu_widget.dart';
import 'script_menu_widget.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  initState() {
    context.read<LanguageBloc>().add(LanguageEventFetchAll());
    context.read<DialectBloc>().add(DialectEventFetchAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScriptMenuListWidget(),
          LanguageMenuWidget(),
          DialectMenuWiget(),
        ],
      ),
    );
  }
}
