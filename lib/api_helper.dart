part of plugs;

class QueryParam {
  const QueryParam(this.name, this.value);

  final String name;
  final String value;

  @override
  String toString() =>
      '${Uri.encodeQueryComponent(name)}=${Uri.encodeQueryComponent(value)}';
}

/// Returns the decoded body as UTF-8 if the given headers indicate an 'application/json'
/// content type. Otherwise, returns the decoded body as decoded by dart:http package.
Future<String> _decodeBodyBytes(Response response) async {
  final contentType = response.headers['content-type'];
  return contentType != null &&
          contentType.toLowerCase().startsWith('application/json')
      ? utf8.decode(response.bodyBytes)
      : response.body;
}
