import 'dart:collection';
import 'i_q_hsm_state_machine_helper.dart';
import 'threaded_code_executor.dart';

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

  final Queue<EventWrapper>	_eventsQueue	= Queue<EventWrapper>();
  final IQHsmStateMachineHelper? _helper;
  late String targetState;

  Runner (this._helper);

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
}
