part of 'sound_bloc.dart';

class SoundState extends BaseState<Sound> {
  SoundState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory SoundState.initial() {
    return SoundState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Sound>(),
      selections: BuiltSet<Sound>(),
    );
  }

  @override
  SoundState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Sound>? data,
    BuiltSet<Sound>? selections,
  }) {
    return SoundState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
