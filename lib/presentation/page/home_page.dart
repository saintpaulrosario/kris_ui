import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
import 'package:kris/logic/language/bloc/language_bloc.dart';
import 'package:kris/logic/payload/bloc/payload_bloc.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/image/bloc/image_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/sound/bloc/sound_bloc.dart';
import '../../logic/text/bloc/word_text_bloc.dart';
import '../../logic/word/bloc/word_bloc.dart';
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
        BlocProvider(create: (context) => WordBloc()),
        BlocProvider(create: (context) => ImageBloc()),
        BlocProvider(create: (context) => SoundBloc()),
        BlocProvider(create: (context) => ScriptBloc()),
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(create: (context) => DialectBloc()),
        BlocProvider(create: (context) => WordTextBloc()),
        BlocProvider(create: (context) => ContentBloc()),
        BlocProvider(create: (context) => PayloadBloc()),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        drawer: AppDrawer(),
        body: widget.child,
      ),
    );
  }
}
