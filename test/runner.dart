import 'dart:async';
import 'dart:collection';

class Runner {
  final Queue<Function>	_queue	= Queue<Function>();

  void run (List<Function> functions) {

    print('_queue.size->${_queue.length}');

    _queue.addAll(functions);

    scheduleMicrotask(() {
      while (_queue.isNotEmpty) {
        Function f = _queue.removeFirst();
        f();
      }
    });

  }
}
