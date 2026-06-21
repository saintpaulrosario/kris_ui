part of 'sound_bloc.dart';

class SoundEvent {}

class RetrieveSoundsEvent extends SoundEvent {
  final List<String> skus;

  RetrieveSoundsEvent(this.skus);
}
