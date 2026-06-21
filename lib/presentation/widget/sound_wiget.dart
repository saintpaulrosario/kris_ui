// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:kris/model/idenity.dart';

// class AudioWidget extends StatefulWidget {
//   final List<Identity> sounds;

//   const AudioWidget({super.key, required this.sounds});

//   @override
//   State<AudioWidget> createState() => _AudioWidgetState();
// }

// class _AudioWidgetState extends State<AudioWidget> {
//   late final SoundService soundService;
//   late final AudioPlayer player;

//   @override
//   void initState() {
//     super.initState();
//     soundService = getIt<SoundService>();
//     player = AudioPlayer();
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.sounds.isEmpty) {
//       return const Text("No sound");
//     }
//     return FutureBuilder<String>(
//       future: soundService.fetchByIdentifier(
//         widget.sounds.first.ordinal,
//         widget.sounds.first.sku,
//       ),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }

//         if (snapshot.hasError) {
//           return const Text("Error fetching");
//           //return const Text("Error loading sound");
//         }

//         if (!snapshot.hasData || snapshot.data == null) {
//           return const Text("No sound");
//         }

//         var sound = snapshot.data;
//         // Assuming sound.data is Base64 String:
//         Uint8List soundBytes = base64Decode(sound!);
//         var source = BytesSource(soundBytes);

//         return ElevatedButton.icon(
//           onPressed: () async {
//             await player.play(source);
//           },
//           icon: const Icon(Icons.play_circle_fill),
//           label: const Text('Play'),
//         );
//       },
//     );
//   }
// }
