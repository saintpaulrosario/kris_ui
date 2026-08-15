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
  final int pageNumber;
  final int pageSize;
  final bool selected;
  final Set<String> scripts;
  final Set<String> languages;
  final Set<String> dialects;

  const BaseEvent._({
    required this.type,
    required this.identifier,
    required this.pageNumber,
    required this.pageSize,
    required this.selected,
    required this.scripts,
    required this.dialects,
    required this.languages,
  });

  factory BaseEvent.fetch({required int pageNumber, required int pageSize}) {
    return BaseEvent._(
      type: WordFetchType.page,
      pageNumber: pageNumber,
      pageSize: pageSize,
      identifier: Identifier.initial(),
      selected: false,
      scripts: {},
      dialects: {},
      languages: {},
    );
  }

  factory BaseEvent.bySku({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.bySku,
      identifier: identifier,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      scripts: {},
      dialects: {},
      languages: {},
    );
  }

  factory BaseEvent.textBySku({
    required Identifier identifier,
    required Set<String> scripts,
  }) {
    return BaseEvent._(
      type: WordFetchType.textBySku,
      identifier: identifier,
      scripts: scripts,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      dialects: {},
      languages: {},
    );
  }

  factory BaseEvent.contentBySku({
    required Identifier identifier,
    required Set<String> languages,
  }) {
    return BaseEvent._(
      type: WordFetchType.contentBySku,
      identifier: identifier,
      languages: languages,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      scripts: {},
      dialects: {},
    );
  }

  factory BaseEvent.payloadBySku({
    required Identifier identifier,
    required Set<String> dialects,
  }) {
    return BaseEvent._(
      type: WordFetchType.payloadBySku,
      identifier: identifier,
      dialects: dialects,
      scripts: {},
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      languages: {},
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
      pageNumber: 0,
      pageSize: 25,
      scripts: {},
      dialects: {},
      languages: {},
    );
  }
}
