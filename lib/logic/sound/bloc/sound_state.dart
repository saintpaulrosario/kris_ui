part of 'sound_bloc.dart';

class SoundState extends BaseState {
  final Map<String, Sound> sounds;

  SoundState({required this.sounds}) : super(errors: {}, fetching: {});

  factory SoundState.initial() {
    return SoundState(sounds: {});
  }

  @override
  SoundState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Sound>? sounds,
  }) {
    return SoundState(sounds: sounds ?? this.sounds);
  }
}
