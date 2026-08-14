import '../model/identifier.dart';

enum WordFetchType {
  page,
  bySku,
  textBySku,
  contentBySku,
  payloadBySku,
  select,
}

class BaseEvent {
  final WordFetchType type;
  final Identifier identifier;
  final int? pageNumber;
  final int? pageSize;
  final bool? selected;

  const BaseEvent._({
    required this.type,
    required this.identifier,
    this.pageNumber,
    this.pageSize,
    this.selected,
  });

  factory BaseEvent.fetch({required int pageNumber, required int pageSize}) {
    return BaseEvent._(
      type: WordFetchType.page,
      pageNumber: pageNumber,
      pageSize: pageSize,
      identifier: Identifier.initial(),
    );
  }

  factory BaseEvent.bySku({required Identifier identifier}) {
    return BaseEvent._(type: WordFetchType.bySku, identifier: identifier);
  }

  factory BaseEvent.textBySku({required Identifier identifier}) {
    return BaseEvent._(type: WordFetchType.textBySku, identifier: identifier);
  }

  factory BaseEvent.contentBySku({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.contentBySku,
      identifier: identifier,
    );
  }

  factory BaseEvent.payloadBySku({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.payloadBySku,
      identifier: identifier,
    );
  }

  factory BaseEvent.select({
    required Identifier identifier,
    required bool selected,
  }) {
    return BaseEvent._(
      type: WordFetchType.select,
      identifier: identifier,
      selected: selected,
    );
  }
}
