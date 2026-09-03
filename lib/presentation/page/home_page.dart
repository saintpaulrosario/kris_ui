import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/word/defintion_bloc.dart';
import 'package:kris/logic/word/dialect_bloc.dart';
import 'package:kris/logic/word/example_bloc.dart';
import 'package:kris/logic/word/language_bloc.dart';
import 'package:kris/logic/word/script_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/logic/word/type_bloc.dart';
import 'package:kris/logic/word/word_bloc.dart';

import 'app_bar_widget.dart';
import 'app_drawer.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MediumBloc()),
        BlocProvider(create: (context) => WordBloc()),
        BlocProvider(create: (context) => TranslationBloc()),
        BlocProvider(create: (context) => ScriptBloc()),
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(create: (context) => DialectBloc()),
        BlocProvider(create: (context) => ExampleBloc()),
        BlocProvider(create: (context) => DefinitionBloc()),
        BlocProvider(create: (context) => TypeBloc()),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        drawer: AppDrawer(),
        body: widget.child,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ConvexAppBar(
            style: TabStyle.reactCircle,
            items: [
              TabItem(icon: Icons.list),
              TabItem(icon: Icons.calendar_today),
              TabItem(icon: Icons.assessment),
            ],
            initialActiveIndex: 1,
            onTap: (int i) => print('click index=$i'),
          ),
        ),
      ),
    );
  }
}
