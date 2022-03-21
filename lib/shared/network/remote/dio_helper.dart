import 'package:dio/dio.dart';

import '../../components/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: Constants.BASE_URL, receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({String? url, Map<String,dynamic>? query}) async {
    return await dio.get(url!, queryParameters: query);
  }
}
