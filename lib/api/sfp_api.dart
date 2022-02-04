part of plugs;

class SfpApi {
  //
  final ApiClient apiClient;

  SfpApi(this.apiClient);

  ///
  Future<SfpPlugState> getState() async {
    const path = r'.cgi';
    final queryParams = <QueryParam>[];
    const body = null;
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
      'GET',
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

    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.statusCode != HttpStatus.noContent) {
      return await deserializeAsync(
        DeserializationMessage(
          json: await _decodeBodyBytes(response),
          targetType: (SfpPlugState).toString(),
        ),
      ) as SfpPlugState;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  ///
  Future<Response> _writeMemoryWithHttpInfo(Flw flw) async {
    const path = r'/flw.cgi';
    final queryParams = <QueryParam>[];
    final body = flw.toMap();
    final headerParams = <String, String>{};
    final formParams = <String, String>{};
    const contentTypes = <String>['application/json'];
    const authNames = <String>[
      'BasicAuthentication',
      'QuerystringAuthentication',
      'TokenAuthentication',
    ];

    //
    return await apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      body,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes[0],
      authNames,
    );
  }

  ///
  Future<void> setState(Flw flw) async {
    final response = await _writeMemoryWithHttpInfo(flw);

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
