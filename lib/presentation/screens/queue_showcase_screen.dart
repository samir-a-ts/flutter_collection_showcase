import 'dart:async';
import 'dart:collection';

import 'package:async/async.dart';
import 'package:collection_showcase/presentation/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class QueueShowcaseScreen extends StatelessWidget {
  const QueueShowcaseScreen({super.key});

  static final _eventQueue = EventQueue();

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      title: 'Очередь',
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: double.infinity, height: 0),
          ElevatedButton(
            onPressed: () {
              _eventQueue.add(EventType.add);
            },
            child: const Text('Добавить'),
          ),
          ElevatedButton(
            onPressed: () {
              _eventQueue.add(EventType.remove);
            },
            child: const Text('Удалить'),
          ),
          ElevatedButton(
            onPressed: () {
              _eventQueue.add(EventType.clear);
            },
            child: const Text('Очистить'),
          ),
        ],
      ),
    );
  }
}

enum EventType {
  add,
  remove,
  clear,
}

class EventQueue {
  void _processEvent(EventType event) {
    switch (event) {
      case EventType.add:
        debugPrint('Добавление');
        break;
      case EventType.remove:
        debugPrint('Удаление');
        break;
      case EventType.clear:
        debugPrint('Очистка');
        break;
    }
  }

  final _asyncCache = AsyncCache(const Duration(seconds: 2));

  Future<void> startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_events.isNotEmpty) {
        final event = _events.removeLast();
        _processEvent(event);
      } else {
        timer.cancel();
      }
    });
  }

  final _events = Queue<EventType>();

  void add(EventType type) {
    _asyncCache.fetch(startTimer);

    _events.add(type);
  }
}
