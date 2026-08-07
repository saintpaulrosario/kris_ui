import 'package:json_annotation/json_annotation.dart';

part 'authenticate_response.g.dart';

@JsonSerializable()
class AuthenticateResponse {
  @JsonKey(defaultValue: '')
  final String accessToken;

  @JsonKey(defaultValue: '')
  final String refreshToken;

  AuthenticateResponse({required this.accessToken, required this.refreshToken});

  factory AuthenticateResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateResponseToJson(this);

  factory AuthenticateResponse.initial() {
    return AuthenticateResponse(accessToken: '', refreshToken: '');
  }
}
