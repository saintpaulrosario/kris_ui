part of 'sound_bloc.dart';

class SoundState extends BaseState<Sound> {
  SoundState({
    required super.errors,
    required super.fetching,
    required super.data,
  });

  factory SoundState.initial() {
    return SoundState(errors: {}, fetching: {}, data: {});
  }

  @override
  SoundState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Map<String, Sound>? data,
  }) {
    return SoundState(
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
    );
  }
}
