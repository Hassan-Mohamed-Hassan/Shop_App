import 'package:dio/dio.dart';
class DioHelper {
  static late Dio dio;
  static initDio() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/',
        )
    );
  }

  static Future<Response> postDate({
     url,
    queryParameters,
    data,
   String ?token,
    lang
}) async {
    return await dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers:{
        'lang':lang??'ar',
        'Authorization':token,
      'Content-Type':'application/json',
      }),
    );
  }

  static Future<Response> putDate({
    url,
    queryParameters,
    data,
    String ?token,
  }) async {
    return await dio.put(
      url,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers:{
        'lang':'ar',
        'Authorization':token,
        'Content-Type':'application/json',
      }),
    );
  }

  static Future<Response> GetData({
    url,
    queryParameters,
    String ?token,
  }) async {
    return await dio.get(
      url,
      queryParameters: queryParameters,
      options: Options(headers:{
        'lang':'en',
        'Authorization':token,
        'Content-Type':'application/json',
      }),
    );
  }

static Future<Response>DeletData({
  url,
  queryParameters,
  String ?token,
})async{
  return await dio.delete(url,options:Options(
   headers: {
     'lang':'en',
     'Authorization':token,
     'Content-Type':'application/json',
   }
 ));
  }
}