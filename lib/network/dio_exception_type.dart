import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';
import 'package:oivan_task/network/remote_error_listener.dart';

class CustomDioException implements Exception {
  late String errorMessage;
  late final int? statusCode;
  late final dynamic errorData;
  RemoteErrorListener? _notifyListeners;

  CustomDioException.fromDioError(DioException dioError) {
    statusCode = dioError.response?.statusCode;
    errorData = dioError.response?.data;

    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = LocaleKeys.errors_timeout.tr();
        _notifyListeners?.onTimeout();
        break;
      case DioExceptionType.badCertificate:
        errorMessage = LocaleKeys.errors_bad_certificate.tr();
        _notifyListeners?.onServerError();
        break;
      case DioExceptionType.badResponse:
        errorMessage = LocaleKeys.errors_bad_request.tr();
        break;
      case DioExceptionType.cancel:
        errorMessage = LocaleKeys.errors_request_cancelled.tr();
        break;
      case DioExceptionType.connectionError:
        errorMessage = LocaleKeys.errors_no_internet_connection.tr();
        _notifyListeners?.onNetworkError();
        break;
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          errorMessage = LocaleKeys.errors_no_internet_connection.tr();
          _notifyListeners?.onNetworkError();
        } else {
          errorMessage = LocaleKeys.errors_unexpected_error_occurred.tr();
          _notifyListeners?.onServerError();
        }
        break;
    }
  }

  void setErrorListener(RemoteErrorListener listener) {
    _notifyListeners = listener;
  }

  @override
  String toString() => errorMessage;
}
