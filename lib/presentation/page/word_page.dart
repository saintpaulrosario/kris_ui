import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/word/translation_bloc.dart';
import 'package:kris/model/content.dart';
import 'package:kris/model/payload.dart';
import 'package:kris/model/trait.dart';
import 'package:kris/model/translation.dart';
import 'package:kris/model/text.dart' as w;
import 'package:kris/presentation/widget/carousel_widget.dart';

import 'package:kris/presentation/widget/word_widget.dart';
import '../../logic/base_event.dart';
import '../../logic/base_state.dart';

import '../../response/page_result.dart';
import '../widget/image_list_widget.dart';
import '../widget/pagination_widget.dart';
import '../widget/transcription/transcription_wdiget.dart';
import '../widget/translation/translation_widget.dart';
import '../widget/transliteration/transcription_wdiget.dart';

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
      BaseState<Translation, w.Text, Content, Payload, Trait>,
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

        return Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                trackVisibility: true,
                thumbVisibility: true,
                thickness: 14,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.separated(
                      controller: _scrollController,

                      itemCount: state.content.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        Translation translation = state.content.elementAt(
                          index,
                        );

                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 5,
                                child: ImageListWidget(
                                  key: ValueKey('${translation.sku}-images'),
                                  identifiers: translation.images,
                                ),
                              ),

                              Flexible(
                                flex: 55,
                                child: WordWidget(translation: translation),
                              ),

                              Flexible(
                                flex: 1,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.bookmark),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PaginationWidget(pages: state),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
