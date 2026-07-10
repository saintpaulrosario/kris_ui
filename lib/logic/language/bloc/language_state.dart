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
      errors: errors ?? Map.from(this.errors),
      fetching: fetching ?? Set.from(this.fetching),
      data: data ?? Map.from(this.data),
      selections: selections ?? Set.from(this.selections),
    );
  }
}
