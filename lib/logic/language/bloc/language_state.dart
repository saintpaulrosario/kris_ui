part of 'language_bloc.dart';

class LanguageState extends BaseState<Language> {
  final Set<Word> selections;

  LanguageState({
    required super.errors,
    required super.fetching,
    required super.data,
    required this.selections,
  });
  factory LanguageState.initial() {
    return LanguageState(errors: {}, fetching: {}, data: {}, selections: {});
  }

  @override
  LanguageState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Set<Word>? selections,
    Map<String, Language>? data,
  }) {
    return LanguageState(
      errors: errors ?? this.errors,
      fetching: fetching ?? this.fetching,
      data: data ?? this.data,
      selections: selections ?? this.selections,
    );
  }
}
