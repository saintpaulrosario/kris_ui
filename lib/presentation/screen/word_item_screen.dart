import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../widget/image_list_widget.dart';

class WordItemScreen extends StatefulWidget {
  final Word word;
  const WordItemScreen({super.key, required this.word});

  @override
  State<WordItemScreen> createState() => _WordItemScreenState();
}

class _WordItemScreenState extends State<WordItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WordBloc>().add(RetrieveWordBySkuEvent(sku: widget.word.sku));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.fetching) {
          return const CircularProgressIndicator();
        }

        if (!state.success) {
          return const Text('Failed to retrieve word');
        }
        return Row(
          children: [
            ImageListWidget(images: state.selection.images),
            // sound widget
            // text widget -> content widget
            Text(widget.word.sku),
            Text(widget.word.ordinal.toString()),
          ],
        );
      },
    );
  }
}
