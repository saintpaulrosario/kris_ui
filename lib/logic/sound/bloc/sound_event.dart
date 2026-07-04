part of 'sound_bloc.dart';

class SoundEvent {}

class SoundEventFetchBySku extends SoundEvent {
  final String sku;

  SoundEventFetchBySku(this.sku);
}
