// Flutter imports:
// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:io';

import 'package:bookbox/domain/auth/repository/token_repository.dart';
import 'package:bookbox/http/api_response.dart';
import 'package:bookbox/http/app_exception.dart';
import 'package:bookbox/http/interceptor/dio_retry_interceptor.dart';
import 'package:flutter/foundation.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Project imports:

final apiProvider = Provider<ApiProvider>(ApiProvider.new);

class ApiProvider {
  ApiProvider(this._ref) {
    _dio = Dio();
    _dio.options.sendTimeout = const Duration(seconds: 10);
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(
      DioRetryInterceptor(
        dio: _dio,
        connectivity: Connectivity(),
      ),
    );

    if (dotenv.env['API_URL'] != null) {
      _url = dotenv.env['API_URL']!;
    }
  }
  final Logger logger = Logger("DIO");
  final Ref _ref;

  late final Dio _dio;

  // final transaction = Sentry.startTransaction(
  //   'web-request',
  //   'request',
  //   bindToScope: true,
  // );

  late final TokenRepository _tokenRepository =
      _ref.read(tokenRepositoryProvider);

  late String _url;

  final String _contentType = "application/json";

  Future<ApiResponse> post(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    String requestUrl = _url + path;

    String contentType = _contentType;

    Map<String, dynamic> headers = {
      "accept": "*/*",
      "Content-Type": contentType,
    };
    try {
      final response = await _dio.post(
        requestUrl,
        data: body,
        queryParameters: query,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: options ??
            Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (response.statusCode! < 300) {
        return ApiResponse.success(response);
      } else {
        if (response.statusCode! == 401) {
          return const ApiResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const ApiResponse.error(AppException.error());
        } else {
          return response.data['message'] != null
              ? ApiResponse.error(AppException.errorWithMessage(
                  response.data['message'] as String))
              : const ApiResponse.error(AppException.error());
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return ApiResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return ApiResponse.error(
          AppException.errorWithMessage(e.message ?? "Post Error"));
    } on Error catch (e) {
      return ApiResponse.error(
        AppException.errorWithMessage(e.stackTrace.toString()),
      );
    }
  }

  Future<ApiResponse> patch(
    String path,
    dynamic body, {
    String? token,
    Map<String, String?>? query,
  }) async {
    String requestUrl = _url + path;

    String contentType = _contentType;

    Map<String, dynamic> headers = {
      "accept": "*/*",
      "Content-Type": contentType,
    };

    try {
      // final jwt = await _tokenRepository.getJwt();
      // if (jwt != null) {
      //   headers["Authorization"] = "Bearer $jwt";
      // }

      final response = await _dio.patch(
        requestUrl,
        data: body,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );

      if (response.statusCode == null) {
        return const ApiResponse.error(AppException.connectivity());
      }

      if (response.statusCode! < 300) {
        return ApiResponse.success(response.data);
      } else {
        if (response.statusCode! == 401) {
          return const ApiResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const ApiResponse.error(AppException.error());
        } else {
          return response.data['message'] != null
              ? ApiResponse.error(AppException.errorWithMessage(
                  response.data['message'] as String))
              : const ApiResponse.error(AppException.error());
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return ApiResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return ApiResponse.error(
          AppException.errorWithMessage(e.message ?? "Patch Error"));
    } on Error catch (e) {
      return ApiResponse.error(
        AppException.errorWithMessage(e.stackTrace.toString()),
      );
    }
  }

  Future<ApiResponse> get(
    String path, {
    String? url,
    String? token,
    Map<String, String?>? query,
    Options? options,
    void Function(int, int)? onReceiveProgress,
  }) async {
    String requestUrl = url == "" || url == null ? _url + path : url + path;
    String contentType = _contentType;

    Map<String, dynamic> headers = {
      "accept": "*/*",
      "Content-Type": contentType,
    };
    try {
      final response = await _dio.get(
        requestUrl,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
        onReceiveProgress: onReceiveProgress,
      );
      log(response.headers.toString());

      if (response.statusCode == null) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (response.statusCode! < 300) {
        return ApiResponse.success(response.data);
      } else {
        if (response.statusCode! == 404) {
          return const ApiResponse.error(AppException.connectivity());
        } else if (response.statusCode! == 401) {
          return const ApiResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const ApiResponse.error(AppException.error());
        } else {
          return response.data['error'] != null
              ? ApiResponse.error(AppException.errorWithMessage(
                  response.data['error'] as String))
              : const ApiResponse.error(AppException.error());
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return ApiResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return ApiResponse.error(
          AppException.errorWithMessage(e.message ?? "GET $path Error"));
    } on Error catch (e) {
      return ApiResponse.error(
        AppException.errorWithMessage(e.stackTrace.toString()),
      );
    }
  }

  Future<ApiResponse> delete(
    String path, {
    String? url,
    String? token,
    Map<String, String?>? query,
  }) async {
    String requestUrl = url == "" || url == null ? _url + path : url + path;
    String contentType = _contentType;

    Map<String, dynamic> headers = {
      "accept": "*/*",
      "Content-Type": contentType,
    };
    try {
      // final jwt = await _tokenRepository.getJwt();
      // if (jwt != null) {
      //   headers["Authorization"] = "Bearer $jwt";
      // } else {
      //   headers["Authorization"] = "Bearer $token";
      // }

      final response = await _dio.delete(
        requestUrl,
        queryParameters: query,
        options: Options(validateStatus: (status) => true, headers: headers),
      );
      if (response.statusCode == null) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (response.statusCode! < 300) {
        return ApiResponse.success(response.data);
      } else {
        if (response.statusCode! == 404) {
          return const ApiResponse.error(AppException.connectivity());
        } else if (response.statusCode! == 401) {
          return const ApiResponse.error(AppException.unauthorized());
        } else if (response.statusCode! == 502) {
          return const ApiResponse.error(AppException.error());
        } else {
          return response.data['error'] != null
              ? ApiResponse.error(AppException.errorWithMessage(
                  response.data['error'] as String))
              : const ApiResponse.error(AppException.error());
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const ApiResponse.error(AppException.connectivity());
      }
      if (e.response != null) {
        if (e.response!.data['message'] != null) {
          return ApiResponse.error(AppException.errorWithMessage(
              e.response!.data['message'] as String));
        }
      }
      return ApiResponse.error(
          AppException.errorWithMessage(e.message ?? "DELETE $path Error"));
    } on Error catch (e) {
      return ApiResponse.error(
        AppException.errorWithMessage(e.stackTrace.toString()),
      );
    }
  }
}
