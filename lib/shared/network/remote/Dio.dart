import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<dynamic> getData(
  {
    required String url,
    Map<String,dynamic>? query,
    String? token ,
    String lang = 'en',
  })
  async{
    dio?.options.headers =
    {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return await dio!.get(url,queryParameters: query);
  }
  
  static Future<dynamic> postData(
      {
        required String url,
        required Map<String, dynamic> data,
        Map<String,dynamic>? query,
        String lang = 'en',
        String? token ,
      }
  )
  async{
    dio?.options.headers =
    {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<dynamic> putData(
      {
        required String url,
        required Map<String, dynamic> data,
        Map<String,dynamic>? query,
        String lang = 'en',
        String? token ,
      }
      )
  async{
    dio?.options.headers =
    {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}