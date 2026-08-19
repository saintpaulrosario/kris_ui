import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/text.dart' as w;

import 'package:kris/presentation/widget/word_widget.dart';
import '../../logic/base_event.dart';
import '../../logic/base_state.dart';

import '../../model/word.dart';
import '../../response/page_result.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    context.read<TranslationBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 50),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocSelector<
      TranslationBloc,
      BaseState<Translation, w.Text, Content, Payload>,
      PageResult<Translation>?
    >(
      selector: (state) {
        return state.pages[state.pageNumber];
      },
      builder: (context, state) {
        if (state == null) {
          return const SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        return Scrollbar(
          controller: _scrollController,
          trackVisibility: true,
          thumbVisibility: true,
          thickness: 9,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.separated(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: state.content.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  Word word = state.content.elementAt(index);

                  return WordWidget(word: word);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
