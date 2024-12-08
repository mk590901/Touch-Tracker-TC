import 'dart:async';
import 'dart:collection';

import 'i_q_hsm_state_machine_helper.dart';
import 'threaded_code_executor.dart';
//import 'utils.dart';

// class FunWrapper {
//   final Object? _data;
//   final Function _function;
//   FunWrapper(this._function, this._data);
//
//   Object? data() {
//     return _data;
//   }
//   Function function() {
//     return _function;
//   }
// }

class EventWrapper {
  final Object? _data;
  final String  _event;

  EventWrapper(this._event, this._data);

  Object? data() {
    return _data;
  }

  String event() {
    return _event;
  }
}


class Runner {

  //final Queue<FunWrapper>	_queue	= Queue<FunWrapper>();
  final Queue<EventWrapper>	_eventsQueue	= Queue<EventWrapper>();
  final IQHsmStateMachineHelper? _helper;
  late String targetState;

  Runner (this._helper);

  void setStateMock([Object? data]) {
    print ('setState($data)');
  }

  void setState([Object? data]) {
    print ('******* Runner.setState($data) *******');
    String targetState = data == null ? '' : data as String;
    _helper?.setState(targetState);
  }

  void post(String event, [Object? data]) {
    //print('post.addQueue [$event($data)]');
    _eventsQueue.add(EventWrapper(event, data));
    while (_eventsQueue.isNotEmpty) {
      EventWrapper eventWrapper = _eventsQueue.removeFirst();
      //print('post event [${eventWrapper.event()}, ${eventWrapper.data()}]');
      ThreadedCodeExecutor? executor = _helper?.executor(eventWrapper.event());
      executor?.executeSync(data);
    }
  }

  // void run (List<Function> functions, String targetState, [Object? data]) {
  //
  //   print('- _queue.size->${_queue.length}');
  //
  //   for (Function fun in functions) {
  //     _queue.add(FunWrapper(fun, data));
  //   }
  //   //_queue.add(FunWrapper(setStateMock,targetState));
  //   _queue.add(FunWrapper(setState,targetState));
  //
  //   print('+ _queue.size->${_queue.length}');
  //
  //   scheduleMicrotask(() {
  //     while (_queue.isNotEmpty) {
  //       FunWrapper funWrapper = _queue.removeFirst();
  //       print ('CALL ${funWrapper.function()}');
  //       funWrapper.function()(funWrapper.data());
  //      }
  //   });
  //
  // }

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
