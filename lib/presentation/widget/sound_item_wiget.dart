import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/medium/bloc/medium_bloc.dart';
import 'package:kris/logic/medium_state.dart';

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
    context.read<MediumBloc>().add(
      MediumEventFetch(sku: widget.identifier.sku),
    );
    player = AudioPlayer(playerId: widget.identifier.sku);
    super.initState();
  }

  Future<void> _play(Sound sound) async {
    try {
      final bytes = Uint8List.fromList(base64Decode(sound.content));

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
    return BlocSelector<
      MediumBloc,
      MediumState,
      ({bool fetching, Sound? sound})
    >(
      selector: (state) {
        return (
          fetching: state.fetching.contains(widget.identifier.sku),
          sound: state.data[widget.identifier.sku],
        );
      },

      builder: (context, state) {
        if (state.fetching) {
          return CircularProgressIndicator();
        }

        if (state.sound == null) {
          return TextButton(
            onPressed: null,
            child: const Icon(Icons.volume_off),
          );
        }

        return TextButton(
          onPressed: () => _play(state.sound!),
          child: const Icon(Icons.volume_up),
        );
      },
    );
  }
}
