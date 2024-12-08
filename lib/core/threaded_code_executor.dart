import 'i_q_hsm_state_machine_helper.dart';
import 'runner.dart';

class ThreadedCodeExecutor {

  late Runner runner;
  final List<Function> _functions;
  final IQHsmStateMachineHelper _helper;
  final String _targetState;

  ThreadedCodeExecutor(this._helper, this._targetState, this._functions) {
    runner = Runner(_helper);
  }

  void post(String event, [Object? data]) {
    runner.post(event, data);
  }

  // void execute([Object? data]) {
  //   runner.run( _functions, _targetState, data);
  // }

  // void executeAsync([Object? data]) {
  //   runner.run( _functions, _targetState, data);
  // }

  void executeSync([Object? data]) {
    //print ('- executeSync -');
    _helper.setState(_targetState);
     for (Function func in _functions) {
       //print('executeSync $func');
      func(data);
    }
    //_helper.setState(_targetState);
    //print ('+ executeSync +');
  }

  // void trace(String state, String event) {
  //   print('[$state,$event]: $_functions -> [$_targetState]');
  // }

}
