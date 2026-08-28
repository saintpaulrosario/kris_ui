import 'package:flutter/material.dart';

class TranscriptionWdiget extends StatefulWidget {
  const TranscriptionWdiget({super.key});

  @override
  State<TranscriptionWdiget> createState() => _TranscriptionWdigetState();
}

class _TranscriptionWdigetState extends State<TranscriptionWdiget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Text("some transcription")),
          Flexible(child: Text("Transcription")),
        ],
      ),
    );
  }
}
