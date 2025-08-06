import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:oivan_task/generated/locale_keys/locale_keys.g.dart';

abstract class RemoteErrorListener {
  void handleRemoteError(DioException error);
  void onTimeout();
  void onNetworkError();
  void onUnauthorized();
  void onServerError();
  void onBadRequest(Map<String, dynamic>? data);
}

class StateRemoteErrorListener implements RemoteErrorListener {
  final void Function(String errorMessage) onErrorState;

  StateRemoteErrorListener(this.onErrorState);

  @override
  void handleRemoteError(DioException error) {
    final message =
        error.message ?? LocaleKeys.errors_unexpected_error_occurred.tr();
    onErrorState(message);
  }

  @override
  void onBadRequest(Map<String, dynamic>? data) {
    final message =
        _extractErrorMessage(data) ?? LocaleKeys.errors_bad_request.tr();
    onErrorState(message);
  }

  @override
  void onNetworkError() {
    onErrorState(LocaleKeys.errors_no_internet_connection.tr());
  }

  @override
  void onServerError() {
    onErrorState(LocaleKeys.errors_server_error.tr());
  }

  @override
  void onTimeout() {
    onErrorState(LocaleKeys.errors_timeout.tr());
  }

  @override
  void onUnauthorized() {
    onErrorState(LocaleKeys.errors_unauthorized.tr());

    ///TODO:Handle Unauthorized Error
  }

  String? _extractErrorMessage(Map<String, dynamic>? data) {
    if (data == null) return null;

    if (data.containsKey('message')) {
      return data['message']?.toString();
    }
    if (data.containsKey('error')) {
      return data['error']?.toString();
    }
    if (data.containsKey('error_description')) {
      return data['error_description']?.toString();
    }

    return null;
  }
}
