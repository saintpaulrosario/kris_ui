// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'definition_api.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter,avoid_unused_constructor_parameters,unreachable_from_main,avoid_redundant_argument_values

class _DefinitionApi implements DefinitionApi {
  _DefinitionApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'http://127.0.0.1:8074';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<ApiResult<PageResult<Definition>>>> fetchAll({
    int? page,
    int? size,
    List<String>? scripts,
    List<String>? identifiers,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'size': size,
      r'scripts': scripts,
      r'identifiers': identifiers,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<ApiResult<PageResult<Definition>>>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/definition',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<PageResult<Definition>> _value;
    try {
      _value = ApiResult<PageResult<Definition>>.fromJson(
        _result.data!,
        (json) => PageResult<Definition>.fromJson(
          json as Map<String, dynamic>,
          (json) => Definition.fromJson(json as Map<String, dynamic>),
        ),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<Definition>>> fetch({
    required String identifier,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<Definition>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/${identifier}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<Definition> _value;
    try {
      _value = ApiResult<Definition>.fromJson(
        _result.data!,
        (json) => Definition.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<Text>>> fetchText({
    required String identifier,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<Text>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/text/${identifier}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<Text> _value;
    try {
      _value = ApiResult<Text>.fromJson(
        _result.data!,
        (json) => Text.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<List<Text>>>> fetchTexts({
    List<String>? scripts,
    List<String>? identifiers,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'scripts': scripts,
      r'identifiers': identifiers,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<List<Text>>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/text',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<List<Text>> _value;
    try {
      _value = ApiResult<List<Text>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<Text>((i) => Text.fromJson(i as Map<String, dynamic>))
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<Content>>> fetchContent({
    required String identifier,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<Content>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/content/${identifier}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<Content> _value;
    try {
      _value = ApiResult<Content>.fromJson(
        _result.data!,
        (json) => Content.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<List<Content>>>> fetchContents({
    List<String>? identifiers,
    List<String>? scripts,
    List<String>? languages,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'identifiers': identifiers,
      r'scripts': scripts,
      r'languages': languages,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<List<Content>>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/content',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<List<Content>> _value;
    try {
      _value = ApiResult<List<Content>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<Content>(
                    (i) => Content.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<Payload>>> fetchPayload({
    required String identifier,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<Payload>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/payload/${identifier}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<Payload> _value;
    try {
      _value = ApiResult<Payload>.fromJson(
        _result.data!,
        (json) => Payload.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<List<Payload>>>> fetchPayloads({
    List<String>? identifiers,
    List<String>? dialects,
    List<String>? scripts,
    List<String>? languages,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'identifiers': identifiers,
      r'dialects': dialects,
      r'scripts': scripts,
      r'languages': languages,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<List<Payload>>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/payload',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<List<Payload>> _value;
    try {
      _value = ApiResult<List<Payload>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<Payload>(
                    (i) => Payload.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<List<DefinitionTrait>>>> fetchTraits({
    List<String>? identifiers,
    List<String>? dialects,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'identifiers': identifiers,
      r'dialects': dialects,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<ApiResult<List<DefinitionTrait>>>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/definition/trait',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<List<DefinitionTrait>> _value;
    try {
      _value = ApiResult<List<DefinitionTrait>>.fromJson(
        _result.data!,
        (json) => json is List<dynamic>
            ? json
                  .map<DefinitionTrait>(
                    (i) => DefinitionTrait.fromJson(i as Map<String, dynamic>),
                  )
                  .toList()
            : List.empty(),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ApiResult<DefinitionTrait>>> fetchTrait({
    required String identifier,
  }) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<ApiResult<DefinitionTrait>>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/definition/trait/${identifier}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late ApiResult<DefinitionTrait> _value;
    try {
      _value = ApiResult<DefinitionTrait>.fromJson(
        _result.data!,
        (json) => DefinitionTrait.fromJson(json as Map<String, dynamic>),
      );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options, response: _result);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
