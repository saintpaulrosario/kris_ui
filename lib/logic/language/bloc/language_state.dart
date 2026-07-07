part of 'language_bloc.dart';

class LanguageState extends BaseState {
  final Map<String, Language> languages;
  final Set<Word> selections;

  LanguageState({required this.languages, required this.selections})
    : super(errors: {}, fetching: {});

  factory LanguageState.initial() {
    return LanguageState(languages: {}, selections: {});
  }

  @override
  LanguageState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Set<Word>? selections,
    Map<String, Language>? scripts,
  }) {
    return LanguageState(
      languages: scripts ?? this.languages,
      selections: selections ?? this.selections,
    );
  }
}
