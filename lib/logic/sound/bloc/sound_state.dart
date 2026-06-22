part of 'sound_bloc.dart';

class SoundState extends BaseState {
  final List<Sound> sounds;
  final List<Sound> selections;
  final Sound selection;
  SoundState({
    required this.sounds,
    required this.selections,
    required this.selection,
  }) : super(
         failure: false,
         fetching: false,
         success: false,
         message: '',
         error: ErrorResponse.initial(),
       );

  factory SoundState.initial() {
    return SoundState(
      sounds: [],
      selections: [],
      selection: Sound.fromJson({}),
    );
  }

  SoundState copyWith({
    ErrorResponse? error,
    bool? success,
    String? message,
    int? code,
    bool? fetching,
    List<Sound>? sounds,
    List<Sound>? selections,
    Sound? selection,
    bool? failure,
  }) {
    return SoundState(
      sounds: sounds ?? this.sounds,
      selections: selections ?? this.selections,
      selection: selection ?? this.selection,
    );
  }
}
