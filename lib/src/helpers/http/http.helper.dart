import 'package:dio/dio.dart';

class HttpHelper {
  static Dio? _client;

  static Future<Dio> _getInstance() async {
    if (_client == null) {
      _client = Dio();

      // Here, we should probably load the API key with the dotenv package for security reasons.
      // But for easier access to the exercise, it will stay this way:
      _client!.options.queryParameters.addAll({"appid": "ce4daa5ea0b4ad0375a012ebcc575a61"});
    }
    return _client!;
  }

  static Future<Response> get(String url, {dynamic queryParameters}) async {
    final instance = await _getInstance();
    return instance.get(url, queryParameters: queryParameters);
  }

  static Future<Response> post(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.post(url, data: body);
  }

  static Future<Response> put(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.put(url, data: body);
  }

  static Future<Response> delete(String url, {dynamic body}) async {
    final instance = await _getInstance();
    return instance.delete(url);
  }
}
