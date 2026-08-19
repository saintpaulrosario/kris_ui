import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/medium/medium_state.dart';
import 'package:kris/model/medium.dart';

import '../../model/sound.dart';

class SoundWidget extends StatefulWidget {
  final Medium sound;

  const SoundWidget({super.key, required this.sound});

  @override
  State<SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  late final AudioPlayer player;

  @override
  void initState() {
    player = AudioPlayer(playerId: widget.sound.sku);
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextButton(
        onPressed: () async {
          try {
            final bytes = Uint8List.fromList(
              base64Decode(widget.sound.content),
            );
            await player.play(BytesSource(bytes));
          } catch (e) {
            debugPrint("Audio playback error: $e");
          }
        },
        child: const Icon(Icons.volume_up),
      ),
    );
  }
}
