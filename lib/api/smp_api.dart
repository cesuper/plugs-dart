part of plugs;

class SmpApi extends AinApi {
  SmpApi(ApiClient apiClient) : super(apiClient);

  ///
  @override
  Future<SmpPlugState> getState() async {
    //
    final response = await getStateWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (SmpPlugState).toString(),
        ),
      ) as SmpPlugState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<SmpAinParams> getAinParams() async {
    final response = await super.getAinParamsWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (SmpAinParams).toString(),
        ),
      ) as SmpAinParams;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<SmpAinState> getBuffer() async {
    final response = await super.getBufferWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (SmpAinState).toString(),
        ),
      ) as SmpAinState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  @override
  Future<SmpAinState> buffer() async {
    final response = await super.bufferWithHttpInfo();

    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (SmpAinState).toString(),
        ),
      ) as SmpAinState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }
}
