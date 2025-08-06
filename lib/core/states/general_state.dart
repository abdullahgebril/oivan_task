import 'package:flutter/material.dart';

extension GeneralStateExtension<T> on GeneralState {
  Widget when({
    Widget Function()? idle,
    required Widget Function() loading,
    Widget Function()? failure,
    required Widget Function(T data) onSuccess,
    Widget Function(String? message)? onError,
  }) {
    final state = this;
    if (state is SuccessGeneralState<T>) {
      return onSuccess(state.data);
    } else if (state == GeneralState.idle) {
      return idle?.call() ?? const SizedBox();
    } else if (state == GeneralState.loading) {
      return loading.call();
    } else if (state == GeneralState.failure) {
      return failure?.call() ?? const SizedBox();
    } else if (state is ErrorGeneralState) {
      return onError?.call(state.message) ?? const SizedBox();
    }
    return const SizedBox();
  }
}

/// A generalized operation state.
mixin GeneralState {
  /// No action.
  static const idle = _GeneralState.idle;

  /// An operation is currently being executed.
  static const loading = _GeneralState.loading;

  /// The current operation failed.
  static const failure = _GeneralState.failure;

  /// the current operation is error state take an object for error
  static GeneralState error<T>(String? message) {
    return ErrorGeneralState<T>._(message);
  }

  /// Error state with original bilingual messages for dynamic language switching
  static GeneralState errorWithMessages<T>(
      String? message, List? originalMessages) {
    return ErrorGeneralState<T>._(message, originalMessages);
  }

  /// The current operation finished successfully with result of [data].
  static GeneralState success<T>(T data) {
    return SuccessGeneralState<T>._(data);
  }
}

enum _GeneralState implements GeneralState {
  idle,
  loading,
  failure;
}

/// The success variant of [GeneralState]
/// The current operation finished successfully with result of [data].
class SuccessGeneralState<T> implements GeneralState {
  final T data;

  const SuccessGeneralState._(this.data);
}

class ErrorGeneralState<T> implements GeneralState {
  final String? message;
  final List? originalMessages; // Store original bilingual messages

  const ErrorGeneralState._(this.message, [this.originalMessages]);
}

extension GeneralStateUtils on GeneralState {
  bool isSuccess() {
    return this is SuccessGeneralState;
  }

  bool isLoading() {
    return this == _GeneralState.loading;
  }

  T? getData<T>() {
    final state = this;
    return state is SuccessGeneralState<T> ? state.data : null;
  }
}
