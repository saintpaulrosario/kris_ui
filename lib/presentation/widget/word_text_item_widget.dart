// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../logic/base_event.dart';
// import '../../logic/base_state.dart';
// import '../../logic/translation/bloc/translation_bloc.dart';
// import '../../model/identifier.dart';
// import '../../model/translation.dart';
// import '../../model/translation_content.dart';
// import '../../model/translation_payload.dart';
// import '../../model/translation_text.dart';
// import 'content_list_widget.dart';
// import 'word_widget.dart';

// class WordTextItemWidget extends StatefulWidget {
//   final Identifier identifier;
//   final Set<String> visited;
//   final String maya;

//   const WordTextItemWidget({
//     super.key,
//     required this.identifier,
//     required this.visited,
//     required this.maya,
//   });

//   @override
//   State<WordTextItemWidget> createState() => _WordTextItemWidgetState();
// }

// class _WordTextItemWidgetState extends State<WordTextItemWidget>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();

//     context.read<TranslationBloc>().add(
//       BaseEvent.textBySku(identifier: widget.identifier),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     return BlocSelector<
//       TranslationBloc,
//       BaseState<
//         Translation,
//         TranslationText,
//         TranslationContent,
//         TranslationPayload
//       >,
//       TranslationText?
//     >(
//       selector: (state) {
//         return state.texts[widget.identifier.sku];
//       },
//       builder: (context, text) {
//         if (text == null) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return _buildTranslation(context, text);
//       },
//     );
//   }

//   Widget _buildTranslation(BuildContext context, TranslationText text) {
//     return Stack(
//       children: [
//         // ====================================================
//         // TEXT | SCRIPT CONTENT
//         // ====================================================
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if ('SCRIPT' == widget.maya)
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: WordWidget(
//                     key: ValueKey('${text.script.sku}_script'),
//                     identifier: text.script,
//                     maya: 'SCRIPT',
//                     visited: {...widget.visited, text.sku},
//                   ),
//                 ),
//               ),

//             const SizedBox(width: 1),
//             // ==================================================
//             // TEXT
//             // ==================================================
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: ContentListWidget(
//                   key: ValueKey('${text.sku}_content'),
//                   identifiers: text.contents,
//                   maya: widget.maya,
//                   visited: {...widget.visited, text.sku},
//                 ),
//               ),
//             ),

//             // ==================================================
//             // SCRIPT
//             // ==================================================
//           ],
//         ),

//         // ====================================================
//         // CONTINUOUS TEXT / SCRIPT DIVIDER
//         // ====================================================
//         Positioned(
//           top: 0,
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: IgnorePointer(
//             child: Row(
//               children: [
//                 const Spacer(),

//                 // Text column = 50%
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       width: 1,
//                       color: Theme.of(context).dividerColor,
//                     ),
//                   ),
//                 ),

//                 const Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
