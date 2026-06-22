part of 'image_bloc.dart';

class ImageEvent {}

class RetrieveImagesBySkuEvent extends ImageEvent {
  final String sku;

  RetrieveImagesBySkuEvent({required this.sku});
}

class RetrieveImagesByOrdinalsEvent extends ImageEvent {
  final List<String> ordinals;

  RetrieveImagesByOrdinalsEvent({required this.ordinals});
}

class ImageSelectedEvent extends ImageEvent {
  final Image image;

  ImageSelectedEvent({required this.image});
}
