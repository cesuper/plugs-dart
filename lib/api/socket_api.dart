part of plugs;

class SocketApi {
  //
  final ApiClient apiClient;

  //
  SocketApi(this.apiClient);

  // TODO: POST MEMORY

  //
  Future<dynamic> readMemory() async {
    const path = r'/memory.cgi';
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

    return jsonDecode(response.body);
  }

  //
  Future<Response> _writeMemoryWithHttpInfo(Object? content) async {
    const path = r'/memory.cgi';
    final queryParams = <QueryParam>[];
    final body = content;
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
  Future<void> writeMemory(Object? content) async {
    final response = await _writeMemoryWithHttpInfo(content);

    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
