import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class DioRetryInterceptor extends Interceptor {
  final Dio dio;
  final Connectivity connectivity;

  DioRetryInterceptor({
    required this.dio,
    required this.connectivity,
  });

  Logger log = Logger("Dio Retry Interceptor");

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      try {
        requestRetry(err.requestOptions);
      } catch (e) {
        log.warning("Dio Error", [e]);
      }
    }
    super.onError(err, handler);
  }

  Future<Response> requestRetry(RequestOptions requestOptions) {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();
    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connect) {
        if (connect != ConnectivityResult.none) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                sendTimeout: requestOptions.sendTimeout,
                receiveTimeout: requestOptions.receiveTimeout,
                extra: requestOptions.extra,
                headers: requestOptions.headers,
                responseType: requestOptions.responseType,
                contentType: requestOptions.contentType,
                validateStatus: requestOptions.validateStatus,
                receiveDataWhenStatusError:
                    requestOptions.receiveDataWhenStatusError,
                followRedirects: requestOptions.followRedirects,
                maxRedirects: requestOptions.maxRedirects,
                requestEncoder: requestOptions.requestEncoder,
                responseDecoder: requestOptions.responseDecoder,
                listFormat: requestOptions.listFormat,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout && err.error != null;
  }
}
