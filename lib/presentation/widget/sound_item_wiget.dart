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
    return BlocSelector<SoundBloc, SoundState, bool>(
      selector: (state) {
        return state.fetching.contains(widget.identifier.sku);
      },
      builder: (context, state) {
        if (state) {
          return ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_fill),
            label: const Text('no found'),
          );
        }

        return BlocSelector<SoundBloc, SoundState, Sound?>(
          selector: (state) {
            return state.data[widget.identifier.sku];
          },
          builder: (context, state) {
            if (state == null) {
              return ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_delete_outlined),
                label: const Text('no found'),
              );
            }
            return ElevatedButton.icon(
              onPressed: () async {
                await player.play(
                  BytesSource(
                    Uint8List.fromList(base64Decode(state.payload)),
                    mimeType: state.contentType,
                  ),
                );
              },
              icon: const Icon(Icons.play_circle_fill),
              label: const Text('Play'),
            );
          },
        );
      },
    );
  }
}
