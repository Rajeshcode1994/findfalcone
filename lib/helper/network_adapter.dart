import 'package:dio/dio.dart';

import 'exceptions.dart';

class NetworkAdapters {
  //singleton
  static final NetworkAdapters shared = NetworkAdapters._privateConstructor();

  NetworkAdapters._privateConstructor();

  static BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 60, seconds: 10000),
      receiveTimeout: const Duration(minutes: 60, seconds: 10000),
      contentType: Headers.jsonContentType,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 2000;
      });

  Dio _dioInstance() {
    Dio dio = Dio(options);
    options.headers.addAll({'Content-Type': 'application/json'});

    return dio;
  }

  Future<Response> get(
      {required String endPoint,
        Map<String, dynamic>? params,
        Map<String, dynamic>? queryParams}) async {

    Response? response;
    try {
      response = await _dioInstance()
          .get(endPoint, queryParameters: params ?? queryParams);
    } on DioException catch (error) {
      _handleException(error, response!);
    }

    return _checkAndReturnResponse(response);
  }

  Future<Response> post({required String endPoint,
        Map<String, dynamic>? params,
        Map<String, dynamic>? queryParams}) async {

    Response? response;
    try {
      response = await _dioInstance().request(endPoint,
          data: params,
          queryParameters: queryParams,
          options: Options(method: "POST"));
    } on DioException catch (error) {
      _handleException(error, response!);
    }

    return _checkAndReturnResponse(response);
  }

  dynamic _checkAndReturnResponse(Response response) {
    String? description;
    if (response.data is Map) {
      description =
      response.data.containsKey('error') ? response.data['error'] : null;
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.data == null) {
          throw FetchDataException(
              'Returned response data is null : ${response.statusMessage}');
        }

        return response;
      case 400:
        throw BadRequestException(description ?? response.statusMessage);
      case 401:
      case 403:
        throw UnauthorisedException(description ?? response.statusMessage);
      case 404:
        throw NotFoundException(description ?? response.statusMessage);
      case 500:
        throw InternalServerException(description ?? response.statusMessage);
      default:
        throw FetchDataException(
            "Unknown error occured\n\nerror Code: ${response.statusCode}  "
                "error: ${description ?? response.statusMessage}");
    }
  }

  Response? _handleException(DioError error, Response response) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw FetchDataException('Timeout Error\n\n${error.message}');
      case DioExceptionType.badResponse:
      case DioExceptionType.badCertificate:
        response = error.response!; // If response is available.
        break;
      case DioExceptionType.cancel:
        throw FetchDataException('Request Cancelled\n\n${error.message}');
      case DioExceptionType.unknown:
        String message = error.message!.contains('SocketException')
            ? "No Internet Connection"
            : "Oops, Something went wrong";
        throw FetchDataException('$message\n\n${error.message}');
    }
  }
}