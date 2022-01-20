part of plugs;

String clientVersion = '1.0.0';
String clientName = 'sfp-client-dart';

///
/// Main client class
///
class PlugClient {
  ///
  String url;

  ///
  final bool debug;

  ///
  late Client client;

  /// Create a new instance for Smc
  ///
  /// * [url] - url of the smc
  ///
  PlugClient(this.url, {Client? client, this.debug = false}) {
    //
    this.client = client ?? LoggingClient(debug, Client());

    // set default header for the client
    defaultHeaders['User-Agent'] = '$clientVersion/$clientName';
  }

  /// Closes the client and cleans up any resources associated with it.
  void close() => client.close();

  ///
  Map<String, String> defaultHeaders = {};

  ///
  ApiClient getApiClient({String basePath = '/api'}) {
    final api = ApiClient(url + basePath);
    api._client = client;
    api._defaultHeaderMap.addAll(defaultHeaders);
    return api;
  }

  DeviceApi getDeviceApi() => DeviceApi(getApiClient(basePath: '/api'));

  SfpApi getSfpApi() => SfpApi(getApiClient(basePath: '/api'));

  ///
  //SysApi getSysApi() => SysApi(getApiClient(basePath: '/api/sys'));

  ///
  //AssetApi getAssetApi() => AssetApi(getApiClient(basePath: '/api/asset'));

  ///
  //PlugsApi getPlugsApi() => PlugsApi(getApiClient(basePath: '/api/plugs'));

  ///
  //FlwApi getFlwApi() => FlwApi(getApiClient(basePath: '/api'));
}

/// Logging wrapper for http client.
class LoggingClient extends BaseClient {
  bool debugEnabled = true;
  final Client delegate;

  LoggingClient(this.debugEnabled, this.delegate);

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    if (debugEnabled) {
      _traceRequest(request);
    }
    var send = delegate.send(request);
    if (debugEnabled) {
      send.then((r) {
        logPrint(
            '<< status: ${r.statusCode} - contentLength: ${r.contentLength}');
        logPrint('<< headers: ${r.headers}');
      });
    }
    return send;
  }

  @override
  void close() => delegate.close();

  void _traceRequest(BaseRequest request) {
    logPrint('>> ${request.method} ${request.url} =====');
    logPrint('>> headers: ${request.headers}');
    logPrint('>> contentLength: ${request.contentLength}');
  }
}

/// Log printer; defaults print log to console.
void Function(Object object) logPrint = print;
