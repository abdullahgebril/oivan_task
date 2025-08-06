import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oivan_task/core/constants/endpoints_const.dart';
import 'remote_constants.dart';
import 'remote_error_listener.dart';

class RemoteClientConfigs {
  static final provider = Provider<RemoteClientConfigs>((ref) {
    final endPoints = ref.watch(EndPoints.provider);
    return RemoteClientConfigs.basic(endPoints.apiUrl);
  });

  final String baseurl;
  final Duration? receiveTimeout;
  final Duration? connectionTimeout;
  final Duration? sendTimeout;
  final int numberOfRetries;
  final String authHeader;
  final Map<String, String> headers;
  final List<RemoteErrorListener> errorListeners;
  final Function(Map<String, dynamic> error)? onError;

  const RemoteClientConfigs({
    required this.receiveTimeout,
    required this.connectionTimeout,
    required this.sendTimeout,
    required this.numberOfRetries,
    required this.baseurl,
    required this.headers,
    required this.errorListeners,
    this.authHeader = HttpHeaders.authorizationHeader,
    this.onError,
  });

  const RemoteClientConfigs.basic(
    this.baseurl, {
    this.receiveTimeout = RemoteConstants.receiveTimeout,
    this.sendTimeout = RemoteConstants.sendTimeout,
    this.connectionTimeout = RemoteConstants.connectionTimeout,
    this.numberOfRetries = RemoteConstants.numberOfRetries,
    this.headers = const {},
    this.errorListeners = const [],
    this.authHeader = HttpHeaders.authorizationHeader,
    this.onError,
  });

  const RemoteClientConfigs.empty({
    this.baseurl = '',
    this.receiveTimeout = RemoteConstants.receiveTimeout,
    this.sendTimeout = RemoteConstants.sendTimeout,
    this.connectionTimeout = RemoteConstants.connectionTimeout,
    this.numberOfRetries = RemoteConstants.numberOfRetries,
    this.headers = const {},
    this.errorListeners = const [],
    this.authHeader = HttpHeaders.authorizationHeader,
    this.onError,
  });

  RemoteClientConfigs copyWith({
    String? baseurl,
    Duration? receiveTimeout,
    Duration? connectionTimeout,
    Duration? sendTimeout,
    int? numberOfRetries,
    Map<String, String>? headers,
    String? authHeader,
    List<RemoteErrorListener>? errorListeners,
    Function(Map<String, dynamic> error)? onError,
  }) {
    return RemoteClientConfigs(
      headers: headers ?? this.headers,
      baseurl: baseurl ?? this.baseurl,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      numberOfRetries: numberOfRetries ?? this.numberOfRetries,
      connectionTimeout: connectionTimeout ?? this.connectionTimeout,
      errorListeners: errorListeners ?? this.errorListeners,
      authHeader: authHeader ?? this.authHeader,
      onError: onError ?? this.onError,
    );
  }
}
