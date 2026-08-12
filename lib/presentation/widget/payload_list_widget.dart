// import 'package:flutter/material.dart';

// import '../../model/identifier.dart';
// import 'payload_widget.dart';

// class PayloadListWidget extends StatelessWidget {
//   final List<Identifier> identifiers;
//   final String maya;
//   final Set<String> visited;

//   const PayloadListWidget({
//     super.key,
//     required this.identifiers,
//     required this.maya,
//     required this.visited,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: identifiers.map((identifier) {
//         return Wrap(
//           spacing: 4,
//           runSpacing: 4,
//           children: [
//             PayloadWidget(
//               key: ValueKey('${identifier.sku}_$maya'),
//               identifier: identifier,
//               maya: maya,
//               visited: visited,
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }
