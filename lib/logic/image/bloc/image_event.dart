part of 'image_bloc.dart';

class ImageEvent {}

class RetrieveImagesBySkusEvent extends ImageEvent {
  final List<String> skus;

  RetrieveImagesBySkusEvent({required this.skus});
}

class RetrieveImagesByOrdinalsEvent extends ImageEvent {
  final List<String> ordinals;

  RetrieveImagesByOrdinalsEvent({required this.ordinals});
}

class ImageSelectedEvent extends ImageEvent {
  final Image image;

  ImageSelectedEvent({required this.image});
}
