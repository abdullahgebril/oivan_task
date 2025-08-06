import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_events.dart';

class AppEventListener extends ConsumerStatefulWidget {
  final Widget child;
  final EventBus? bus;
  final FutureOr<void> Function(AppEvent) onListen;

  const AppEventListener({
    super.key,
    this.bus,
    required this.child,
    required this.onListen,
  });

  @override
  AppEventListenerState createState() => AppEventListenerState();
}

class AppEventListenerState extends ConsumerState<AppEventListener> {
  final Queue<AppEvent> _eventQueue = ListQueue();
  final Queue<AppEvent> _priorityQueue = ListQueue();
  int _topCount = 0;
  int _handlesCount = 0;
  late StreamSubscription _subscription;

  void _initEventBus() {
    final EventBus eventBus = widget.bus ?? ref.read(AppEvent.busProvider);
    _subscription = eventBus.on<AppEvent>().listen((event) {
      if (event is UIEvent && event.isUrgent) {
        _priorityQueue.add(event);
      } else {
        _eventQueue.add(event);
      }
      _handleEvents();
    });
  }

  Future<void> _handleEvents() async {
    if (_eventQueue.isEmpty && _priorityQueue.isEmpty) return;
    if (_topCount > 0) return;

    final priorityEvent = _priorityQueue.isEmpty ? null : _priorityQueue.first;
    if (priorityEvent != null) {
      _priorityQueue.remove(priorityEvent);
      _execute(priorityEvent);
      return;
    } else if (_handlesCount > 0) {
      return;
    }

    final normalEvent = _eventQueue.isEmpty ? null : _eventQueue.first;
    if (normalEvent != null) {
      _eventQueue.remove(normalEvent);
      _execute(normalEvent);
    }
  }

  Future<void> _execute(AppEvent event) async {
    _handlesCount += 1;
    if (event is UIEvent && event.isAlwaysTop) {
      _topCount += 1;
    }
    await widget.onListen(event);
    _handlesCount -= 1;
    if (event is UIEvent && event.isAlwaysTop) {
      _topCount -= 1;
    }
    _handleEvents();
  }

  @override
  void initState() {
    log('initState AppEventListener');
    _initEventBus();
    super.initState();
  }

  @override
  void dispose() {
    log('dispose AppEventListener');
    _eventQueue.clear();
    _priorityQueue.clear();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
