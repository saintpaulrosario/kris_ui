import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';

class WordScreen extends StatefulWidget {
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WordBloc()..add(RetrieveWordsEvent()),
      child: BlocBuilder<WordBloc, WordState>(
        builder: (context, state) {
          if (state.fetching) {
            return const CircularProgressIndicator();
          }
          if (state.words!.isEmpty) {
            return const Text('No words available');
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(height: 1.0);
                  },
                  itemCount: state.words!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.words![index].sku ?? ''),
                      subtitle: Text(state.words![index].ordinal.toString()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
