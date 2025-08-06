import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:oivan_task/network/dio_exception_type.dart';
import 'package:oivan_task/network/remote_client_config.dart';

class DioInterceptor extends Interceptor {
  final Logger _logger = Logger();
  final RemoteClientConfigs configs;

  DioInterceptor({
    required this.configs,
  });

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    _logger.i('════════════════════ REQUEST ════════════════════');
    _logger.i('Request: ${options.method} ${options.uri}');
    _logger.i('Headers: ${options.headers}');
    _logger.i('Request Body: ${options.data}');
    _logger.i('Query Parameters: ${options.queryParameters}');
    _logger.i('════════════════════════════════════════════════');
    options.headers.addAll(configs.headers);

    options.receiveTimeout = configs.receiveTimeout;
    options.connectTimeout = configs.connectionTimeout;
    options.sendTimeout = configs.sendTimeout;

    if (kDebugMode) {
      print('REQUEST[${options.method}] => PATH: ${options.path}');
      print('Headers: ${options.headers}');
      if (options.data != null) {
        print('Request Body: ${options.data}');
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('════════════════════ RESPONSE ═══════════════════');
    _logger.i('Status: ${response.statusCode}');
    _logger.i('Response URL: ${response.requestOptions.uri}');
    _logger.i('Response Headers: ${response.headers.map}');
    _logger.i('Response Data: ${response.data}');
    _logger.i('════════════════════════════════════════════════');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('════════════════════ ERROR ═════════════════════');
    _logger.e('Error Type: ${err.type}');
    _logger.e('Status Code: ${err.response?.statusCode}');
    _logger.e('URL: ${err.requestOptions.uri}');
    _logger.e('Request Data: ${err.requestOptions.data}');
    _logger.e('Error Message: ${err.message}');
    _logger.e('Error Response Data: ${err.response?.data}');
    _logger.e('════════════════════════════════════════════════');

    final customError = CustomDioException.fromDioError(err);

    for (final listener in configs.errorListeners) {
      customError.setErrorListener(listener);
      listener.handleRemoteError(err);
    }

    if (configs.onError != null && err.response?.data is Map<String, dynamic>) {
      configs.onError!(err.response!.data as Map<String, dynamic>);
    }

    return super.onError(err, handler);
  }
}
