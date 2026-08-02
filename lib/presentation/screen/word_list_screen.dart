// import 'package:flutter/material.dart';

// import '../../model/identifier.dart';

// class WordListScreen extends StatelessWidget {
//   final List<Identifier> identifiers;

//   const WordListScreen({super.key, required this.identifiers});

//   @override
//   Widget build(BuildContext context) {
//     if (identifiers.isEmpty) {
//       return const Text("No words found");
//     }

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Fixed header
//         Container(
//           padding: const EdgeInsets.all(8),
//           child: const Row(
//             children: [
//               Expanded(child: Text("Ordinal", textAlign: TextAlign.center)),
//               Expanded(child: Text("SKU", textAlign: TextAlign.center)),
//               Expanded(child: Text("Action", textAlign: TextAlign.center)),
//             ],
//           ),
//         ),

//         const Divider(),

//         // Rows
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: identifiers.length,
//           itemBuilder: (context, index) {
//             final identifier = identifiers[index];

//             return Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     '${identifier.ordinal}',
//                     textAlign: TextAlign.center,
//                   ),
//                 ),

//                 Expanded(
//                   child: Text(
//                     identifier.sku.toString(),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),

//                 // Expanded(
//                 //   child: IconButton(
//                 //     icon: const Icon(Icons.open_in_new),
//                 //     onPressed: () {
//                 //       Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //           builder: (_) =>
//                 //               WordItemScreen(identifier: identifier),
//                 //         ),
//                 //       );
//                 //     },
//                 //   ),
//                 // ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
