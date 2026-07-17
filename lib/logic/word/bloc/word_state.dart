part of 'word_bloc.dart';

class WordState extends BaseState<Word> {
  final BuiltMap<int, PageResult<Word>> pages;
  final BuiltSet<String> maya;
  final BuiltSet<Word> scripts;
  final BuiltSet<Word> dialects;
  final BuiltSet<Word> languages;
  final BuiltMap<String, BuiltMap<String, Word>> mayaSelections;
  final String type;
  final int pageNumber;
  final int pageSize;

  WordState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.pages,
    required super.selections,
    required this.pageNumber,
    required this.pageSize,
    required this.maya,
    required this.type,
    required this.scripts,
    required this.dialects,
    required this.languages,
    required this.mayaSelections,
  });

  factory WordState.initial() {
    return WordState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Word>(),
      pages: BuiltMap<int, PageResult<Word>>(),
      selections: BuiltSet<Word>(),
      pageNumber: 0,
      pageSize: 10,
      maya: BuiltSet<String>(),
      type: '',
      scripts: BuiltSet<Word>(),
      dialects: BuiltSet<Word>(),
      languages: BuiltSet<Word>(),
      mayaSelections: BuiltMap<String, BuiltMap<String, Word>>(),
    );
  }

  @override
  WordState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltMap<String, Word>? data,
    BuiltSet<Word>? selections,
    BuiltMap<int, PageResult<Word>>? pages,
    int? pageNumber,
    int? pageSize,
    String? type,
    BuiltSet<String>? maya,
    BuiltSet<Word>? scripts,
    BuiltSet<Word>? languages,
    BuiltSet<Word>? dialects,
    BuiltMap<String, BuiltMap<String, Word>>? mayaSelections,
  }) {
    return WordState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      pages: pages ?? this.pages,
      selections: selections ?? this.selections,
      pageNumber: pageNumber ?? this.pageNumber,
      pageSize: pageSize ?? this.pageSize,
      maya: maya ?? this.maya,
      type: type ?? this.type,
      scripts: scripts ?? this.scripts,
      dialects: dialects ?? this.dialects,
      languages: languages ?? this.languages,
      mayaSelections: mayaSelections ?? this.mayaSelections,
    );
  }
}
