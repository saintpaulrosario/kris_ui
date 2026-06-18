import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/script/bloc/script_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// we want the list of scripts to be available in the home page, so we can use it to navigate to the script screen
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScriptBloc()..add(RetrieveScriptsEvent()),
      child: Scaffold(
        body: Column(
          children: [
            BlocBuilder<ScriptBloc, ScriptState>(
              builder: (context, state) {
                return Row(
                  children: [
                    if (state.fetching) CircularProgressIndicator(),
                    if (state.scripts != null)
                      ...state.scripts!.map(
                        (script) => Text(script.ordinal.toString()),
                      ),
                  ],
                );
              },
            ),
            Text('list of languages'),
            Text('list of dialects'),
            //show fragments of script... maybe a swithc view?
          ],
        ),
      ),
    );
  }
}
