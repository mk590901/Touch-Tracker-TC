import 'i_q_hsm_state_machine_helper.dart';

class ThreadedCodeExecutor {

  final List<Function> _functions;
  final IQHsmStateMachineHelper _helper;
  final String _targetState;

  ThreadedCodeExecutor(this._helper, this._targetState, this._functions);

  void execute([Object? data]) {
    //Future.microtask(() {
      for (Function func in _functions) {
        func(data);
      }
      _helper.setState(_targetState);
    //});
  }
}
