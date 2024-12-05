import 'dart:async';
import 'dart:collection';

class FunWrapper {
  final Object? _data;
  final Function _function;
  FunWrapper(this._function, this._data);

  Object? data() {
    return _data;
  }
  Function function() {
    return _function;
  }
}

class Runner {
  final Queue<FunWrapper>	_queue	= Queue<FunWrapper>();

  late String targetState;

  void setState([Object? data]) {
    print ('setState($data)');
  }

  void run (List<Function> functions, String targetState, [Object? data]) {

    print('_queue.size->${_queue.length}');

    for (Function fun in functions) {
      _queue.add(FunWrapper(fun, data));
    }
    _queue.add(FunWrapper(setState,targetState));

    scheduleMicrotask(() {
      while (_queue.isNotEmpty) {
        FunWrapper funWrapper = _queue.removeFirst();
        funWrapper.function()(funWrapper.data());
       }
    });

  }
}

// class Runner {
//   final Queue<Function>	_queue	= Queue<Function>();
//
//   late String targetState;
//
//   void setState([Object? data]) {
//     print ('setState($data)');
//   }
//
//   void run (List<Function> functions, String targetState, [Object? data]) {
//
//     print('_queue.size->${_queue.length}');
//
//     _queue.addAll(functions);
//     _queue.add(setState);
//
//     scheduleMicrotask(() {
//       while (_queue.isNotEmpty) {
//         Function f = _queue.removeFirst();
//         if (f == setState) {
//           f(targetState);
//         }
//         else {
//           f(data);
//         }
//       }
//     });
//
//   }
// }
