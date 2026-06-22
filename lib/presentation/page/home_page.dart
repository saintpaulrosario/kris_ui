import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';

import '../../logic/image/bloc/image_bloc.dart';
import '../../logic/script/bloc/script_bloc.dart';
import '../../logic/sound/bloc/sound_bloc.dart';
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
      appBar: AppBar(title: const Text('Kris')),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => WordBloc()),
          BlocProvider(create: (context) => ImageBloc()),
          BlocProvider(create: (context) => SoundBloc()),
          BlocProvider(create: (context) => ScriptBloc()),
        ],
        child: WordListScreen(),
      ),
    );
  }
}
