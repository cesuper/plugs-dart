part of plugs;

class ApiClient {
  ///
  ApiClient(this.basePath);

  ///
  final String basePath;

  ///
  var _client = Client();

  /// Requests to use a new HTTP [Client] in this class.
  ///
  /// If the [newClient] is null, an [ArgumentError] is thrown.
  set client(Client newClient) => _client = newClient;

  ///
  final _defaultHeaderMap = <String, String>{};

  ///
  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  ///
  void addDefaultHeader(String key, String value) {
    _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? nullableContentType,
    List<String> authNames,
  ) async {
    /// add default headers
    headerParams.addAll(_defaultHeaderMap);

    final urlEncodedQueryParams = queryParams.map((param) => '$param');

    final queryString = urlEncodedQueryParams.isNotEmpty
        ? '?${urlEncodedQueryParams.join('&')}'
        : '';

    final Uri uri = Uri.parse('$basePath$path$queryString');

    if (nullableContentType != null) {
      headerParams['Content-Type'] = nullableContentType;
    }

    try {
      //
      final msgBody = nullableContentType == 'application/x-www-form-urlencoded'
          ? formParams
          : jsonEncode(body);

      //
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch (method) {
        case 'POST':
          return await _client.post(uri,
              headers: nullableHeaderParams, body: msgBody);
        case 'GET':
          return await _client.get(uri, headers: nullableHeaderParams);
      }
    } on SocketException catch (e, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        e,
        trace,
      );
    } on TlsException catch (e, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        e,
        trace,
      );
    } on IOException catch (e, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        e,
        trace,
      );
    } on ClientException catch (e, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        e,
        trace,
      );
    } on Exception catch (e, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        e,
        trace,
      );
    }
    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  ///
  static dynamic _deserialize(
    dynamic value,
    String targetType, {
    bool? growable,
  }) {
    try {
      switch (targetType) {
        case 'String':
          return '$value';
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'List<String>':
          return List<String>.from(value);
        case 'FlwPlugState':
          return FlwPlugStateOld.fromMap(value);
      }
    } catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError,
          'Exception during deserialization.', error as Exception, trace);
    }

    throw ApiException(
      HttpStatus.internalServerError,
      'Could not find a suitable class for deserialization',
    );
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool? growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
      ? message.json
      : ApiClient._deserialize(
          jsonDecode(message.json),
          targetType,
          growable: message.growable == true,
        );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object value) async => json.encode(value);
