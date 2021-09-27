import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:graphql_crud_operation/Util/Enum.dart';
import 'package:graphql_crud_operation/Util/ViewUtil.dart';

class ApiClient {
  late d.Dio _dio;

  Map<String, dynamic> _header = {};

  _initDio() {
    _header = {"Content-Type": 'application/graphql'};

    _dio = d.Dio(d.BaseOptions(
        baseUrl: "https://examplegraphql.herokuapp.com/", headers: _header));
    _initInterceptors();
  }

  void _initInterceptors() {
    _dio.interceptors.add(d.InterceptorsWrapper(onRequest: (options, handler) {
      print(
          'REQUEST[${options.method}] => PATH: ${"https://examplegraphql.herokuapp.com/"}${options.path} '
          '=> Request Values: param: ${options.queryParameters}, DATA: ${options.data}, => HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
      return handler.next(response);
    }, onError: (err, handler) {
      print(
          'ERROR[${err.response?.statusCode}] => DATA: ${err.response?.data} Message: ${err.message}');
      return handler.next(err);
    }));
  }

  Future requestFormData(
    String url,
    Method method,
    Map<String, dynamic>? params,
    Map<String, File>? files,
  ) async {
    d.Response response;
    _header[d.Headers.contentTypeHeader] = 'multipart/form-data';
    _initDio();

    Map<String, d.MultipartFile> fileMap = {};
    if (files != null) {
      for (MapEntry fileEntry in files.entries) {
        File file = fileEntry.value;
        fileMap[fileEntry.key] = await d.MultipartFile.fromFile(file.path);
      }
    }

    params?.addAll(fileMap);
    final data = d.FormData.fromMap(params!);

    print(data.fields.toString());

    try {
      // Handle response code from api
      if (method == Method.POST) {
        response = await _dio.post(url, data: data);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("UNAUTHORIZED ");
      } else if (response.statusCode == 500) {
        throw Exception("SERVER ERROR ");
      } else {
        throw Exception("SOMETHING ERROR ");
      }

      // Handle Error type if dio catches anything
    } on d.DioError catch (e) {
      e.printError();

      switch (e.type) {
        case d.DioErrorType.connectTimeout:
          ViewUtil.showSnackBar("INTERNET CONNECTION ");
          break;
        case d.DioErrorType.receiveTimeout:
          ViewUtil.showSnackBar("SERVER DELAY ");
          break;
        case d.DioErrorType.other:
          if (e.error is SocketException) {
            ViewUtil.showSnackBar("INTERNET CONNECTION ");
          }
          break;
        case d.DioErrorType.response:
          try {
            final response = e.response;
            if (response != null) {
              final Map data = json.decode(response.toString());

              final code = data['code'];

              if (code < 500) {
                List<String> messages = data['messages'].cast<String>();

                switch (code) {
                  case 401:
                    // ViewUtil.showSnackBar(
                    //     .PLEASE_SIGNIN);
                    ViewUtil.showSnackBar(_extractMessages(messages));

                    // PrefHelper.setString(PrefConstant.TOKEN, "");

                    // Get.offNamedUntil(AppRoutes.SIGNIN_PAGE,
                    //     ModalRoute.withName(AppRoutes.HOMEPAGE));
                    break;
                  default:
                    ViewUtil.showSnackBar(_extractMessages(messages));
                }
              } else {
                ViewUtil.showSnackBar("SERVER ERROR ");
                throw Exception();
              }
            }
          } catch (e) {}
          break;

        default:
      }

      e.printError();
    } catch (e) {
      e.printError();
      throw Exception("SOMETHING ERROR");
    }
  }

  Future request(String url, Method method, Map<String, dynamic>? params,
      String query) async {
    d.Response response;
    _header[d.Headers.contentTypeHeader] = 'application/graphql';
    _initDio();

    try {
      // Handle response code from api
      if (method == Method.POST) {
        response = await _dio.post(
          url,
          data: query,
        );
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("UNAUTHORIZED");
      } else if (response.statusCode == 500) {
        throw Exception("SERVER_ERROR");
      } else {
        throw Exception("SOMETHING_ERROR");
      }

      // Handle Error type if dio catches anything
    } on d.DioError catch (e) {
      e.printError();

      switch (e.type) {
        case d.DioErrorType.connectTimeout:
          ViewUtil.showSnackBar("INTERNET CONNECTION");
          break;
        case d.DioErrorType.receiveTimeout:
          ViewUtil.showSnackBar("SERVER DELAY");
          break;
        case d.DioErrorType.other:
          if (e.error is SocketException) {
            ViewUtil.showSnackBar("INTERNET CONNECTION");
          }
          break;
        case d.DioErrorType.response:
          try {
            final response = e.response;
            if (response != null) {
              final Map data = json.decode(response.toString());

              final code = data['code'];

              if (code < 500) {
                List<String> messages = data['messages'].cast<String>();

                switch (code) {
                  case 401:
                    // PrefHelper.setString(PrefConstant.TOKEN, "").then((value) =>
                    //     Get.offNamedUntil(AppRoutes.SIGNIN_PAGE,
                    //         ModalRoute.withName(AppRoutes.HOMEPAGE)));

                    break;

                  default:
                    ViewUtil.showSnackBar(_extractMessages(messages));

                    throw Exception(_extractMessages(messages));
                }
              } else {
                ViewUtil.showSnackBar("SERVER ERROR");
                throw Exception();
              }
            }
          } catch (e) {
            throw Exception(e);
          }
          break;

        default:
      }

      e.printError();
    } catch (e) {
      e.printError();
      throw Exception("SOMETHING ERROR");
    }
  }

  _extractMessages(List<String> messages) {
    var str = "";

    messages.forEach((element) {
      str += element;
    });

    return str;
  }
}
