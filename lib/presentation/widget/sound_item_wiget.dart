import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/sound/bloc/sound_bloc.dart';
import '../../model/identifier.dart';
import '../../model/sound.dart';

class SoundItemWidget extends StatefulWidget {
  final Identifier identifier;

  const SoundItemWidget({super.key, required this.identifier});

  @override
  State<SoundItemWidget> createState() => _SoundItemWidgetState();
}

class _SoundItemWidgetState extends State<SoundItemWidget> {
  late final AudioPlayer player;

  @override
  void initState() {
    context.read<SoundBloc>().add(SoundEventFetchBySku(widget.identifier.sku));
    player = AudioPlayer(playerId: widget.identifier.sku);
    super.initState();
  }

  Future<void> _play(Sound sound) async {
    try {
      final bytes = Uint8List.fromList(base64Decode(sound.payload));

      await player.play(BytesSource(bytes));
    } catch (e) {
      debugPrint("Audio playback error: $e");
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SoundBloc, SoundState, ({bool fetching, Sound? sound})>(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          sound: state.data[widget.identifier.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return ElevatedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.sim_card_rounded),
            label: const Text("Loading"),
          );
        }

        if (state.sound == null) {
          return ElevatedButton.icon(
            onPressed: null,
            icon: const Icon(Icons.volume_off),
            label: const Text("Not found"),
          );
        }

        return ElevatedButton.icon(
          onPressed: () => _play(state.sound!),
          icon: const Icon(Icons.volume_up),
          label: const Text("Play"),
        );
      },
    );
  }
}
