import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';

typedef VoidCallback = void Function();

abstract class AppEvent extends Equatable {
  static final busProvider = Provider<EventBus>((ref) {
    final bus = EventBus();
    ref.onDispose(bus.destroy);
    return bus;
  });

  final List _props;

  const AppEvent([this._props = const []]);

  @override
  List<Object?> get props => [..._props, runtimeType];
}

abstract class UIEvent extends AppEvent {
  const UIEvent([super.props]);

  bool get isUrgent => false;

  bool get isAlwaysTop => false;
}

class SuccessEvent extends UIEvent {
  final String message;
  final dynamic data;

  SuccessEvent({
    required this.message,
    this.data,
  }) : super([message, data]);
}

class ErrorEvent extends UIEvent {
  final String message;
  final dynamic error;
  final VoidCallback? retry;

  ErrorEvent({
    required this.message,
    this.error,
    this.retry,
  }) : super([message, error, retry]);

  @override
  bool get isUrgent => true;
}

class InfoEvent extends UIEvent {
  final String message;
  final dynamic error;
  final VoidCallback? retry;

  InfoEvent({
    required this.message,
    this.error,
    this.retry,
  }) : super([message, error, retry]);

  @override
  bool get isUrgent => true;
}

class AppEventBus {
  static final EventBus _eventBus = EventBus();

  static EventBus get instance => _eventBus;

  static void fire(AppEvent event) {
    _eventBus.fire(event);
  }

  static Stream<T> on<T extends AppEvent>() {
    return _eventBus.on<T>();
  }
}
