import 'package:dio/dio.dart';
import 'dart:convert' as json;

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://farm-vision.onrender.com",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      Map<String, dynamic>? headers}) async {
    dio!.options.headers = {
      'x-auth-token': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      var data,
      Map<String, dynamic>? query,
      String? token,
      Map<String, dynamic>? headers}) async {
    dio!.options.headers =
        headers ?? {'Content-Type': 'application/json', 'x-auth-token': token};

    return await dio!
        .post(url, data: query == null ? data : json.jsonEncode(query));
  }

  static Future<Response> putData(
      {required String url,
      var data,
      Map<String, dynamic>? query,
      String? token,
      Map<String, dynamic>? headers}) async {
    dio!.options.headers = headers ??
        {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        };

    return await dio!
        .put(url, data: query == null ? data : json.jsonEncode(query));
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'x-auth-token': token,
    };

    return await dio!.delete(url, data: json.jsonEncode(query));
  }
}
