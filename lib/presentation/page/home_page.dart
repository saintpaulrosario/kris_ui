import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
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
        BlocProvider(create: (context) => TranslationBloc()),
        BlocProvider(create: (context) => ScriptBloc()),
      ],
      child: Scaffold(
        //appBar: AppBarWidget(),
        drawer: AppDrawer(),
        body: widget.child,
      ),
    );
  }
}
