part of plugs;

/// Base class for all plugs
abstract class PlugApi {
  //
  final ApiClient apiClient;

  //
  PlugApi(this.apiClient);

  /// abstracts

  /// Returns the plug state
  Future<PlugState> getState();

  /// methods

  /// Restarts the plug with bootloader mode
  Future<void> restart({bool bootloader = false}) async {
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

  /// Writes [content] to socket memory
  Future<void> writeSocket(Object? content) async {
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
}
