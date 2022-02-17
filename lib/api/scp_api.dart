part of plugs;

class SpcApi extends AinApi {
  SpcApi(ApiClient apiClient) : super(apiClient);

  ///
  @override
  Future<ScpPlugState> getState() async {
    final response = await getStateWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (ScpPlugState).toString(),
        ),
      ) as ScpPlugState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<AinState> buffer() async {
    final response = await super.getBufferWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (ScpAinState).toString(),
        ),
      ) as ScpAinState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<ScpAinState> getBuffer() async {
    final response = await super.getBufferWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (ScpAinState).toString(),
        ),
      ) as ScpAinState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<ScpAinParams> getAinParams() async {
    final response = await super.getAinParamsWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (ScpAinParams).toString(),
        ),
      ) as ScpAinParams;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  ///
  Future<void> startPin(
    int index,
    Duration timeout, {
    Duration delay = const Duration(milliseconds: 0),
  }) async {
    const path = '/do/start.cgi';
    final queryParams = <QueryParam>[];
    final body = {
      'pin': index,
      'delay': delay.inMilliseconds,
      'timeout': timeout.inMilliseconds,
    };
    final headerParams = <String, String>{};
    final formParams = <String, String>{};
    final contentTypes = <String>[];
    const authNames = <String>[
      'BasicAuthentication',
      'QuerystringAuthentication',
      'TokenAuthentication',
    ];

    //
    final response = await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      body,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );

    //
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  ///
  Future<void> stopPin(int index) async {
    const path = '/do/stop.cgi';
    final queryParams = <QueryParam>[];
    final body = {'pin': index};
    final headerParams = <String, String>{};
    final formParams = <String, String>{};
    final contentTypes = <String>[];
    const authNames = <String>[
      'BasicAuthentication',
      'QuerystringAuthentication',
      'TokenAuthentication',
    ];

    //
    final response = await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      body,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );

    //
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
