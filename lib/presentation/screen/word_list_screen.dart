import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/identifier.dart';
import 'package:kris/presentation/screen/word_item_screen.dart';

import '../../logic/word/bloc/word_bloc.dart';
import '../../model/word.dart';
import '../widget/content_item_wiget.dart';
import '../widget/image_list_widget.dart';
import '../widget/word_text_item_widget.dart';
import '../widget/word_text_list_wiget.dart';

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  @override
  void initState() {
    context.read<WordBloc>().add(RetrieveWordsEvent());
    super.initState();
  }

  // do define the headers?
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, state) {
        if (state.fetching == true && state.success == false) {
          return const CircularProgressIndicator();
        } else if (state.success == false && state.fetching == false) {
          return const Text('no words yet available');
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.words.length,
                  itemBuilder: (context, index) {
                    Word word = state.words[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 10,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: word.texts.length,
                                        itemBuilder: (context, index) {
                                          Identifier identifier =
                                              word.texts[index];
                                          return WordTextItemWidget(
                                            identifier: identifier,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Flexible(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // LineDivider(),
                                  ImageListWidget(
                                    imagesIdentifiers: word.images,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    //return WordItemScreen(word: word);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
