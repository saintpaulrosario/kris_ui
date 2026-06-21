import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kris/logic/sound/bloc/sound_bloc.dart';
import 'package:kris/model/identifier.dart';

import 'sound_item_wiget.dart';

class SoundListWidget extends StatefulWidget {
  final List<Identifier> sounds;

  const SoundListWidget({super.key, required this.sounds});

  @override
  State<SoundListWidget> createState() => _SoundListWidgetState();
}

class _SoundListWidgetState extends State<SoundListWidget> {
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
    if (widget.sounds.isEmpty) {
      return const Text("No sound");
    }
    return BlocBuilder<SoundBloc, SoundState>(
      builder: (context, state) {
        if (state.fetching) {
          return const CircularProgressIndicator();
        }

        if (state.error.message.isNotEmpty) {
          return Text(state.error.message);
        }

        var sound = state.sounds.first;

        return SoundItemWidget(sound: sound);
      },
    );
  }
}
