part of 'dialect_bloc.dart';

class DialectState extends BaseState {
  final Map<String, Dialect> dialects;
  final Set<Word> selections;

  DialectState({required this.dialects, required this.selections})
    : super(errors: {}, fetching: {});

  factory DialectState.initial() {
    return DialectState(dialects: {}, selections: {});
  }

  @override
  DialectState copyWith({
    Map<String, ErrorResponse>? errors,
    Set<String>? fetching,
    Set<Word>? selections,
    Map<String, Dialect>? dialects,
  }) {
    return DialectState(
      dialects: dialects ?? this.dialects,
      selections: selections ?? this.selections,
    );
  }
}
