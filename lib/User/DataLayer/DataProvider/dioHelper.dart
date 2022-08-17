import 'dart:io';

import 'package:dio/dio.dart';
import 'package:osol/Shared/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) => true,
        headers: {
          'Apipassword': "mimic2022",
          'lang': "en",
        },
      ),
    );
    dio.interceptors.add(PrettyDioLogger(
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Apipassword': "mimic2022",
      'lang': "en",
    };
    final response = await dio.get(
      url,
      queryParameters: query,
      options: options,
    );
    _checkResponseValid(response);
    return response;
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   'Authorization': token != null ? 'Bearer $token' : '',
    //   //   'Accept-Language': Constants.lang,
    // };

    final response = await dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(
        data,
      ),
      options: options,
    );
    _checkResponseValid(response);
    return response;
  }

  static Future<Response> postDataWithAuth({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Apipassword': "mimic2022",
      'lang': "en",
      //   'Accept-Language': Constants.lang,
    };

    final response = await dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
      options: options,
    );
    _checkResponseValid(response);
    return response;
  }

  static Future<Response> postFormData({
    required String url,
    required FormData formData,
    Map<String, dynamic>? query,
    String? token,
    Options? options,
  }) async {
    // dio.options.headers = {
    //   'Authorization': token != null ? 'Bearer $token' : '',
    //   //   'Accept-Language': Constants.lang,
    // };

    final response = await dio.post(
      url,
      queryParameters: query,
      data: formData,
      options: options,
    );
    _checkResponseValid(response);
    return response;
  }

  /// Put Data Function
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   //    'Accept-Language': Constants.lang,
    //   'Authorization': token != null ? 'Bearer $token' : '',
    // };
    final response = await dio.put(
      url,
      data: (data)!,
      queryParameters: query,
    );
    _checkResponseValid(response);
    return response;
  }

  ///Upload File
  static Future<MultipartFile> uploadFile(File file) async {
    return await MultipartFile.fromFile(file.path,
        filename: file.path.split('/').last);
  }

  ///Upload Files
  static Future<List<MultipartFile>> uploadFiles(List<File> file) async {
    return [
      MultipartFile.fromFileSync(file[0].path,
          filename: file[0].path.split('/').last),
      MultipartFile.fromFileSync(file[1].path,
          filename: file[1].path.split('/').last),
    ];
  }

  /// Delete data function
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Content-Type': 'application/json',
    //   //   'Accept-Language': Constants.lang,
    //   'Authorization': token != null ? 'Bearer $token' : '',
    // };

    final response = await dio.delete(
      url,
      data: data,
      queryParameters: query,
    );
    _checkResponseValid(response);
    return response;
  }

  static void _checkResponseValid(Response response) {
    print(response.data.toString());
    return;
    final Map<String, dynamic> data = response.data;

    if (data.containsKey('status')) {
      if (!data['status']) {
        if (data.containsKey('message')) {
          throw data['message'].values.first.first;
        } else {
          throw 'Status is false';
        }
      }
    } else {
      throw 'Not contained status';
    }
  }
}

// class HandlingApis {
//   static Future<Response> postData(
//       {required String url, dynamic data, Map<String, dynamic>? quary}) async {
//     return await DioHelper.postData(
//         url: url, data: data, token: , query: quary);
//   }}
