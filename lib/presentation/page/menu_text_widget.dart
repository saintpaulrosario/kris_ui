// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kris/logic/base_state.dart';
// import 'package:kris/logic/dialect/bloc/dialect_bloc.dart';
// import 'package:kris/logic/language/bloc/language_bloc.dart';
// import 'package:kris/model/dialect.dart';
// import 'package:kris/model/translation_content.dart';
// import 'package:kris/model/translation_payload.dart';
// import 'package:kris/model/translation_text.dart';
// import 'package:kris/presentation/widget/content_item_wiget.dart';

// import '../../logic/base_event.dart';
// import '../../logic/script/bloc/script_bloc.dart';
// import '../../model/identifier.dart';
// import '../../model/language.dart';

// class MenuTextWidget extends StatefulWidget {
//   final Identifier identifier;
//   final bool selected;
//   final ValueChanged<bool> onChanged;
//   final String maya;

//   const MenuTextWidget({
//     super.key,
//     required this.identifier,
//     required this.selected,
//     required this.onChanged,
//     required this.maya,
//   });

//   @override
//   State<MenuTextWidget> createState() => _MenuTextWidgetState();
// }

// class _MenuTextWidgetState extends State<MenuTextWidget>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.maya == 'LANGUAGE') {
//       context.read<LanguageBloc>().add(
//         BaseEvent.textBySku(identifier: widget.identifier),
//       );
//     } else if (widget.maya == 'DIALECT') {
//       context.read<DialectBloc>().add(
//         BaseEvent.textBySku(identifier: widget.identifier),
//       );
//     } else {
//       context.read<ScriptBloc>().add(
//         BaseEvent.textBySku(identifier: widget.identifier),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);

//     if (widget.maya == 'LANGUAGE') {
//       return BlocSelector<
//         LanguageBloc,
//         BaseState<
//           Language,
//           TranslationText,
//           TranslationContent,
//           TranslationPayload
//         >,
//         ({bool fetching, TranslationText? text})
//       >(
//         selector: (state) => (
//           fetching: state.fetching.contains(widget.identifier.sku),
//           text: state.texts[widget.identifier.sku],
//         ),

//         builder: (context, state) {
//           if (state.fetching) {
//             return const Padding(
//               padding: EdgeInsets.all(8),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final text = state.text;

//           if (text == null) {
//             return const SizedBox.shrink();
//           }

//           return _buildMenuText(text);
//         },
//       );
//     }

//     if (widget.maya == 'DIALECT') {
//       return BlocSelector<
//         DialectBloc,
//         BaseState<
//           Dialect,
//           TranslationText,
//           TranslationContent,
//           TranslationPayload
//         >,
//         ({bool fetching, TranslationText? text})
//       >(
//         selector: (state) => (
//           fetching: state.fetching.contains(widget.identifier.sku),
//           text: state.texts[widget.identifier.sku],
//         ),

//         builder: (context, state) {
//           if (state.fetching) {
//             return const Padding(
//               padding: EdgeInsets.all(8),
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }

//           final text = state.text;

//           if (text == null) {
//             return const SizedBox.shrink();
//           }

//           return _buildMenuText(text);
//         },
//       );
//     }

//     return BlocSelector<
//       ScriptBloc,
//       BaseState,
//       ({bool fetching, TranslationText? text})
//     >(
//       selector: (state) => (
//         fetching: state.fetching.contains(widget.identifier.sku),
//         text: state.texts[widget.identifier.sku],
//       ),

//       builder: (context, state) {
//         if (state.fetching) {
//           return const Padding(
//             padding: EdgeInsets.all(8),
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         final text = state.text;

//         if (text == null) {
//           return const SizedBox.shrink();
//         }

//         return _buildMenuText(text);
//       },
//     );
//   }

//   Card _buildMenuText(TranslationText text) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

//       child: Padding(
//         padding: const EdgeInsets.all(8),

//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Checkbox(
//               value: widget.selected,
//               onChanged: (value) {
//                 if (value != null) {
//                   widget.onChanged(value);
//                 }
//               },
//             ),

//             //const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   for (final identifier in text.contents)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 4),
//                       child: ContentItemWidget(
//                         key: ValueKey(identifier.sku),
//                         identifier: identifier,
//                         maya: widget.maya,
//                         visited: {},
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
