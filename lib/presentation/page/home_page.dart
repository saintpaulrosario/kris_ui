import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';

import '../../logic/content/bloc/content_bloc.dart';
import '../../logic/image/bloc/image_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/sound/bloc/sound_bloc.dart';
import '../../logic/text/bloc/word_text_bloc.dart';
import '../../logic/word/bloc/word_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ߞߙߌߛ')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WordBloc()),
          BlocProvider(create: (context) => ImageBloc()),
          BlocProvider(create: (context) => SoundBloc()),
          BlocProvider(create: (context) => ScriptBloc()),
          BlocProvider(create: (context) => WordTextBloc()),
          BlocProvider(create: (context) => ContentBloc()),
        ],
        child: WordListScreen(),
      ),
    );
  }
}
