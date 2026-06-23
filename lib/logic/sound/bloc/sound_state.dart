part of 'sound_bloc.dart';

class SoundState extends BaseState {
  final List<Sound> sounds;
  final List<Sound> selections;
  final Sound selection;
  SoundState({
    required this.sounds,
    required this.selections,
    required this.selection,
    required super.fetching,
    required super.success,
    required super.message,
    required super.error,
  });

  factory SoundState.initial() {
    return SoundState(
      sounds: [],
      selections: [],
      selection: Sound.fromJson({}),
      fetching: false,
      success: false,
      message: '',
      error: ErrorResponse.initial(),
    );
  }

  @override
  SoundState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    bool? fetching,
    List<Sound>? sounds,
    List<Sound>? selections,
    Sound? selection,
  }) {
    return SoundState(
      sounds: sounds ?? this.sounds,
      selections: selections ?? this.selections,
      selection: selection ?? this.selection,
      fetching: fetching ?? this.fetching,
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
