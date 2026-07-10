part of 'language_bloc.dart';

class LanguageState extends BaseState<Language> {
  LanguageState({
    required super.errors,
    required super.fetching,
    required super.data,
    required super.selections,
  });

  factory LanguageState.initial() {
    return LanguageState(
      errors: BuiltMap<String, ErrorResponse>(),
      fetching: BuiltSet<String>(),
      data: BuiltMap<String, Language>(),
      selections: BuiltSet<Language>(),
    );
  }

  @override
  LanguageState copyWith({
    BuiltMap<String, ErrorResponse>? errors,
    BuiltSet<String>? fetching,
    BuiltSet<Language>? selections,
    BuiltMap<String, Language>? data,
  }) {
    return LanguageState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
