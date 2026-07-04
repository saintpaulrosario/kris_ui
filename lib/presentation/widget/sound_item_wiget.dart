import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/model/sound.dart';

import '../../logic/sound/bloc/sound_bloc.dart';
import '../../model/identifier.dart';

class SoundItemWidget extends StatefulWidget {
  final Identifier identifier;

  const SoundItemWidget({super.key, required this.identifier});

  @override
  State<SoundItemWidget> createState() => _SoundItemWidgetState();
}

class _SoundItemWidgetState extends State<SoundItemWidget> {
  late AudioPlayer player;
  @override
  initState() {
    player = AudioPlayer(playerId: widget.identifier.sku);
    context.read<SoundBloc>().add(SoundEventFetchBySku(widget.identifier.sku));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SoundBloc, SoundState, SoundState>(
      selector: (state) {
        return state;
      },
      builder: (context, state) {
        if (state.fetching.contains(widget.identifier.sku)) {
          return const Center(child: CircularProgressIndicator());
        } else if (!state.sounds.containsKey(widget.identifier.sku)) {
          return ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_fill),
            label: const Text('no found'),
          );
        }
        Sound sound = state.sounds[widget.identifier.sku]!;
        Uint8List soundBytes = Uint8List.fromList(base64Decode(sound.payload));
        var source = BytesSource(soundBytes);
        return ElevatedButton.icon(
          onPressed: () async {
            await player.play(source);
          },
          icon: const Icon(Icons.play_circle_fill),
          label: const Text('Play'),
        );
      },
    );
  }
}
