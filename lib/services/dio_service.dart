import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();

    return await dio
        .get(url, options: Options(responseType: ResponseType.json))
        .then((response) => response);
  }
}
