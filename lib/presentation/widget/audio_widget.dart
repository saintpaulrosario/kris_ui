import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kris/model/medium.dart';

class AudioWidget extends StatefulWidget {
  final Medium sound;

  const AudioWidget({super.key, required this.sound});

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget>
    with AutomaticKeepAliveClientMixin {
  late final AudioPlayer player;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return TextButton(
      onPressed: () async {
        try {
          final bytes = Uint8List.fromList(base64Decode(widget.sound.content));
          await player.play(BytesSource(bytes));
        } catch (e) {
          debugPrint("Audio playback error: $e");
        }
      },
      child: const Icon(Icons.volume_up),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
