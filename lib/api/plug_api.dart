part of plugs;

class PlugApi {
  //
  final ApiClient apiClient;

  //
  PlugApi(this.apiClient);

  ///
  Future<Plug> getState() async {
    const path = r'/plug.cgi';
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
          targetType: (Plug).toString(),
        ),
      ) as Plug;
    }
    throw ApiException(response.statusCode, await _decodeBodyBytes(response));
  }

  ///
  Future<Response> _restartWithHttpInfo(bool bootloader) async {
    const path = r'/plug/restart.cgi';
    final queryParams = <QueryParam>[];
    final body = bootloader ? {'bootloader': true} : {};
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
  Future<void> restart({bool bootloader = false}) async {
    final response = await _restartWithHttpInfo(bootloader);

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
