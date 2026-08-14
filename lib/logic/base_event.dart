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
  final Set<String>? scripts;
  final Set<String>? languages;
  final Set<String>? dialects;

  const BaseEvent._({
    required this.type,
    required this.identifier,
    this.pageNumber,
    this.pageSize,
    this.selected,
    this.scripts,
    this.dialects,
    this.languages,
  });

  factory BaseEvent.fetch({
    int? pageNumber,
    int? pageSize,
    Set<String>? scripts,
    Set<String>? languages,
    Set<String>? dialects,
  }) {
    return BaseEvent._(
      type: WordFetchType.page,
      pageNumber: pageNumber,
      pageSize: pageSize,
      scripts: scripts,
      dialects: dialects,
      languages: languages,
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
