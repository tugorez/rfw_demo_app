import 'package:http/http.dart' as http;

class ApiClient {
  static const String _scheme = 'http';
  static const String _host = 'localhost';
  static const int _port = 8080;

  const ApiClient();

  Future<String> fetchRfw(String path) async {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      port: _port,
      path: path,
    );
    final response = await http.post(uri);
    return response.body;
  }
}
