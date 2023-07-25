import 'package:dio/dio.dart';

class DioHelper {
  final _dio = Dio();

  void init() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 80),
      receiveTimeout: const Duration(seconds: 80),
      receiveDataWhenStatusError: true,
    );
  }

  Future<Response> postData({
    required String path,
    required Map<String, dynamic>? data,
  }) async {
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=AAAA2Xqj-dM:APA91bF66dAzusZ-BUFSRQoTIwQtOxZCezXwefyQ_qGM-DmtkW_5KBiQd9Lk1NBQDhGFnhtYGOdTWB4GLEOwCZxEd1bA6rGQQCj8bR3__e6TZz37oTTIhg1QGxxV_6sCpW4NiABStEZ0',
    };
    return await _dio.post(path,data: data);
  }
}
