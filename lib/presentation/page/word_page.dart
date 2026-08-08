import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_flutter/pagination.dart';

import '../../logic/base_event.dart';
import '../../logic/base_state.dart';
import '../../logic/translation/bloc/translation_bloc.dart';
import '../../model/translation.dart';
import '../../model/translation_content.dart';
import '../../model/translation_payload.dart';
import '../../model/translation_text.dart';
import '../../response/page_result.dart';
import '../widget/word_text_item_widget.dart';

class WordPage extends StatefulWidget {
  const WordPage({super.key});

  @override
  State<WordPage> createState() => _WordPageState();
}

class _WordPageState extends State<WordPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    context.read<TranslationBloc>().add(
      BaseEvent.fetch(pageNumber: 0, pageSize: 60),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocSelector<
      TranslationBloc,
      BaseState<
        Translation,
        TranslationText,
        TranslationContent,
        TranslationPayload
      >,
      PageResult<Translation>?
    >(
      selector: (state) {
        return state.pages[state.pageNumber];
      },
      builder: (context, page) {
        if (page == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // ====================================================
            // FIXED HEADER
            // ====================================================
            _buildHeader(context),

            _horizontalDivider(),

            // ====================================================
            // SCROLLING ROWS
            // ====================================================
            Expanded(child: _buildRows(context, page)),

            _horizontalDivider(),

            // ====================================================
            // PAGINATION
            // ====================================================
            _buildPagination(context, page),
          ],
        );
      },
    );
  }

  // ==============================================================
  // HEADER
  // ==============================================================

  Widget _buildHeader(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return SizedBox(
      height: 75,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ------------------------------------------------------
          // IMAGE
          // ------------------------------------------------------
          Expanded(
            child: Center(
              child: Text(
                'Image',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          _verticalDivider(),

          // ------------------------------------------------------
          // DEFINITION
          // ------------------------------------------------------
          Expanded(
            child: Center(
              child: Text(
                'Definition',
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          _verticalDivider(),

          // ------------------------------------------------------
          // TRANSLATION
          // ------------------------------------------------------
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // First header row
                Expanded(
                  child: Center(
                    child: Text(
                      'Translation',
                      style: textStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                _horizontalDivider(),

                // Second header row
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TEXT
                      Expanded(
                        child: Center(
                          child: Text(
                            'Text',
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      // SINGLE TEXT/SCRIPT DIVIDER
                      _verticalDivider(),

                      // SCRIPT
                      Expanded(
                        child: Center(
                          child: Text(
                            'Script',
                            style: textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ROWS
  // ==============================================================

  Widget _buildRows(BuildContext context, PageResult<Translation> page) {
    return ListView.separated(
      itemCount: page.content.length,
      separatorBuilder: (context, index) {
        return _horizontalDivider();
      },
      itemBuilder: (context, index) {
        final identifier = page.content[index];

        return _buildRow(context, identifier);
      },
    );
  }

  // ==============================================================
  // ROW
  // ==============================================================

  Widget _buildRow(BuildContext context, dynamic identifier) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ------------------------------------------------------
          // IMAGE
          // ------------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text('Image', textAlign: TextAlign.center)),
            ),
          ),

          _verticalDivider(),

          // ------------------------------------------------------
          // DEFINITION
          // ------------------------------------------------------
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text('Definition', textAlign: TextAlign.center),
              ),
            ),
          ),

          _verticalDivider(),

          // ------------------------------------------------------
          // TRANSLATION
          // ------------------------------------------------------
          //
          // WordTextItemWidget owns:
          //
          //      Text | Script
          //
          // because it is the widget that knows the
          // TranslationText and its script.
          //
          Expanded(
            flex: 2,
            child: WordTextItemWidget(
              key: ValueKey('${identifier.sku}_translation'),
              identifier: identifier,
              maya: '',
              visited: {identifier.sku},
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // VERTICAL DIVIDER
  // ==============================================================

  Widget _verticalDivider() {
    return Container(width: 1, color: Theme.of(context).dividerColor);
  }

  // ==============================================================
  // HORIZONTAL DIVIDER
  // ==============================================================

  Widget _horizontalDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Theme.of(context).dividerColor,
    );
  }

  // ==============================================================
  // PAGINATION
  // ==============================================================

  Widget _buildPagination(BuildContext context, PageResult<Translation> page) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Pagination(
        numOfPages: page.page.totalPages,
        selectedPage: page.page.number + 1,
        pagesVisible: page.page.totalPages > 5 ? 5 : page.page.totalPages,
        onPageChanged: (int selectedPage) {
          context.read<TranslationBloc>().add(
            BaseEvent.fetch(
              pageNumber: selectedPage - 1,
              pageSize: page.page.size,
            ),
          );
        },
        activeTextStyle: const TextStyle(),
        activeBtnStyle: const ButtonStyle(),
        inactiveTextStyle: const TextStyle(),
        inactiveBtnStyle: const ButtonStyle(),
      ),
    );
  }
}
