import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kris/model/sound.dart';

class SoundItemWidget extends StatelessWidget {
  final Sound sound;

  const SoundItemWidget({super.key, required this.sound});

  @override
  Widget build(BuildContext context) {
    final AudioPlayer player = AudioPlayer();
    // Assuming sound.data is Base64 String
    Uint8List soundBytes = Uint8List.fromList(base64Decode(sound.payload));
    var source = BytesSource(soundBytes);

    return Expanded(
      child: ElevatedButton.icon(
        onPressed: () async {
          await player.play(source);
        },
        icon: const Icon(Icons.play_circle_fill),
        label: const Text('Play'),
      ),
    );
  }
}
