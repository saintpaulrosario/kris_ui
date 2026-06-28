part of 'sound_bloc.dart';

class SoundEvent {}

class RetrieveSoundsEvent extends SoundEvent {
  final String sku;

  RetrieveSoundsEvent(this.sku);
}
