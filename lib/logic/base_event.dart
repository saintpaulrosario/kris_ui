import '../model/identifier.dart';

enum WordFetchType {
  page,
  identifier,
  text,
  texts,
  content,
  contents,
  payload,
  payloads,
  select,
  selects,
  trait,
  traits,
}

class BaseEvent {
  final WordFetchType type;
  final Identifier identifier;
  final List<Identifier> identifiers;
  final int? pageNumber;
  final int? pageSize;
  final bool selected;
  final List<Identifier>? scripts;
  final List<Identifier>? languages;
  final List<Identifier>? dialects;

  const BaseEvent._({
    required this.type,
    required this.identifier,
    required this.pageNumber,
    required this.pageSize,
    required this.selected,
    required this.identifiers,
    this.scripts,
    this.dialects,
    this.languages,
  });

  factory BaseEvent.fetch({
    int? pageNumber,
    int? pageSize,
    List<Identifier>? scripts,
  }) {
    return BaseEvent._(
      type: WordFetchType.page,
      pageNumber: pageNumber,
      pageSize: pageSize,
      identifier: Identifier.initial(),
      selected: false,
      scripts: scripts,
      dialects: [],
      languages: [],
      identifiers: [],
    );
  }

  factory BaseEvent.identifier({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.identifier,
      identifier: identifier,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      scripts: [],
      dialects: [],
      languages: [],
      identifiers: [],
    );
  }

  factory BaseEvent.text({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.text,
      identifier: identifier,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      dialects: [],
      languages: [],
      scripts: [],
      identifiers: [],
    );
  }

  factory BaseEvent.texts({
    required List<Identifier> identifiers,
    List<Identifier>? scripts,
  }) {
    return BaseEvent._(
      type: WordFetchType.texts,
      identifiers: identifiers,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      dialects: [],
      languages: [],
      scripts: scripts,
      identifier: Identifier.initial(),
    );
  }

  factory BaseEvent.content({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.content,
      identifier: identifier,
      languages: [],
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      scripts: [],
      dialects: [],
      identifiers: [],
    );
  }

  factory BaseEvent.contents({
    required List<Identifier> identifiers,
    required List<Identifier> scripts,
    required List<Identifier> languages,
  }) {
    return BaseEvent._(
      type: WordFetchType.contents,
      identifier: Identifier.initial(),
      languages: languages,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      scripts: scripts,
      dialects: [],
      identifiers: identifiers,
    );
  }

  factory BaseEvent.payload({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.payload,
      identifier: identifier,
      dialects: [],
      scripts: [],
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      languages: [],
      identifiers: [],
    );
  }

  factory BaseEvent.payloads({
    required List<Identifier> identifiers,
    required List<Identifier> dialects,
    required List<Identifier> scripts,
    required List<Identifier> languages,
  }) {
    return BaseEvent._(
      type: WordFetchType.payloads,
      identifier: Identifier.initial(),
      dialects: dialects,
      scripts: scripts,
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      languages: languages,
      identifiers: identifiers,
    );
  }

  factory BaseEvent.trait({required Identifier identifier}) {
    return BaseEvent._(
      type: WordFetchType.trait,
      identifier: identifier,
      dialects: [],
      scripts: [],
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      languages: [],
      identifiers: [],
    );
  }

  factory BaseEvent.traits({
    required List<Identifier> identifiers,
    required List<Identifier> dialects,
  }) {
    return BaseEvent._(
      type: WordFetchType.traits,
      identifier: Identifier.initial(),
      dialects: dialects,
      scripts: [],
      pageNumber: 0,
      pageSize: 25,
      selected: false,
      languages: [],
      identifiers: identifiers,
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
      scripts: [],
      dialects: [],
      languages: [],
      identifiers: [],
    );
  }

  factory BaseEvent.selects({
    required List<Identifier> identifiers,
    required bool selected,
  }) {
    return BaseEvent._(
      type: WordFetchType.selects,
      identifier: Identifier.initial(),
      selected: selected,
      pageNumber: 0,
      pageSize: 25,
      scripts: [],
      dialects: [],
      languages: [],
      identifiers: identifiers,
    );
  }
}
