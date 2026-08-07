import 'package:json_annotation/json_annotation.dart';

part 'authenticate_request.g.dart';

@JsonSerializable()
class AuthenticateRequest {
  final String principal;
  final String secret;

  AuthenticateRequest({required this.principal, required this.secret});

  factory AuthenticateRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateRequestToJson(this);
}
