part of plugs;

abstract class AinApi extends PlugApi {
  AinApi(ApiClient apiClient) : super(apiClient);

  ///
  Future<AinParams> getAinParams();

  @protected
  Future<Response> getAinParamsWithHttpInfo() async {
    const path = '/ain.cgi';
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

    return response;
  }

  ///
  Future<void> setAinParams(AinParams params) async {
    const path = r'/ain.cgi';
    final queryParams = <QueryParam>[];
    final body = params.toMap();
    final headerParams = <String, String>{};
    final formParams = <String, String>{};
    const contentTypes = <String>['application/json'];
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

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  ///
  Future<AinState> buffer();

  @protected
  Future<Response> bufferWithHttpInfo() async {
    const path = '/ain/buffer.cgi';
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
    return response;
  }

  ///
  Future<AinState> getBuffer();

  @protected
  Future<Response> getBufferWithHttpInfo() async {
    const path = '/ain/buffer.cgi';
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

    return response;
  }
}
