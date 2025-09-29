import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio;

  HttpClient(this.dio);

  Future<Response> get(String url) async {
    return await dio.get(url);
  }
}
