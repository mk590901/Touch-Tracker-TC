//	Class Sw1Helper automatically generated at 2024-12-04 10:04:16
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';

import 'dart:math';

import 'gesture/gesture_manager.dart';
import 'helpers/velocity_helper.dart';
import 'q_interfaces/i_gesture_listener.dart';
import 'q_support/tracker.dart';
import 'timer_objects/time_machine.dart';

class TrackHelper {
	//////////////////////////////////////////////////////////////////////////////
	final int 				_pointer;
	Point<double>?		_downPoint;
	Point<double>?		_lastPoint;
	bool              _pause          = false;

	final TimeMachine _timeMachine    = TimeMachine();
	late  String      _timer          = "";

	final VelocityHelper    _velocityHelper = VelocityHelper  (8);

	final int  TIMEOUT_FOR_LONG_PRESS = 1000;
	final double THRESHOLD       = 25.0;  //  16.0 - Ok
//////////////////////////////////////////////////////////////////////////////

	final QHsmHelper	helper_ = QHsmHelper('GestureTrack');

	TrackHelper(this._pointer) {
		createHelper();
	}

	void moveInit(int time, double x, double y) {
		_velocityHelper .init(time, x, y);
	}

	void moveDone(int time, double x, double y, Tracker tracker) {
		double average = _velocityHelper .velocity(time, x, y);
		if (average >= 0.01) {
			tracker.setCurrentPoint(Point<double>(x.round().toDouble(),y.round().toDouble()));
		}
	}

	void moveStop() {
		_velocityHelper .reset();
	}

	void setDownPoint(Point<double> point) {
		_downPoint  = point;
		//print('setDownPoint->[${point.x},${point.y}]');
	}

	void startNotifier (String timerIdent, String action) {
		DateTime now = DateTime.now();
		print('[$timerIdent] $action ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
	}

	void finalNotifier (String timerIdent, String action) {
		DateTime now = DateTime.now();
		print('[$timerIdent] $action ${now.hour}:${now.minute}:${now.second}:${now.millisecond}');
		//done(ObjectEvent(TrackContextObject.Timeout, "TIMEOUT"));
		run('Timeout', "TIMEOUT");

	}

	void setLastPoint(Object? data) {
		_lastPoint = data as Point<double>;
	}

	Point<double>? getLastPoint() {
		return  _lastPoint;
	}

	void setPause(bool enable) {
		_pause = enable;
	}

	bool isPause() {
		return  _pause;
	}

	bool isFirstMove(double x, double y) {
		double  dx    = x    - _downPoint!.x;
		double  dy    = y    - _downPoint!.y;
		double  shift = (dx*dx + dy*dy);
		return  shift < THRESHOLD ? false : true;
	}

	// void gesturetrackEntry([Object? data]) {
	// }

	// void gesturetrackInit([Object? data]) {
	// }

	// void idleEntry([Object? data]) {
	// }

	void idleTouchdown([Object? data]) {
		setDownPoint(data as Point<double>);
		_timer = _timeMachine.invoke(TIMEOUT_FOR_LONG_PRESS, startNotifier, finalNotifier);
	}

	// void insidetouchdownEntry([Object? data]) {
	// }

	void idleTouchup([Object? data]) {
		_timeMachine.delete(_timer);
	}

	// void idleExit([Object? data]) {
	// }

	// void movingExit([Object? data]) {
	// }

	void movingTouchup([Object? data]) {
		GestureManager.manager()?.eventMove(_pointer, ActionModifier.Final, data as Point<double>);
	}

	// void movingTouchmove([Object? data]) {
	// }

	void movingEntry([Object? data]) {
		double average  = _velocityHelper.average();

		//print('onMovingEntry->$average -> $_pause');

		if (average >= 0.01) {
			//print('onMovingEntry.MOVE');
			GestureManager.manager()?.eventMove(_pointer, ActionModifier.Continue, data as Point<double>);

			setLastPoint(data);
			setPause(false);
		}
		else { //print('PAUSE');
			if (!isPause()) {
				//  _gesture.onPause(_pointer, data);
				GestureManager.manager()?.eventPause(_pointer, data as Point<double>);
				setPause(true);
			}
		}

	}

	// void checkmoveExit([Object? data]) {
	// }

	void checkmoveTouchup([Object? data]) {
		_timeMachine.delete(_timer);
		GestureManager.manager()?.eventTap(_pointer, _downPoint!);
	}

	// void checkmoveTouchmove([Object? data]) {
	// }

	void checkmoveEntry([Object? data]) {
		if (data is! Point<double>) {
			return;
		}
		Point<double> point = data;
		if (isFirstMove(point.x, point.y)) {
			run('MoveStart',data);
		}
	}

	void checkmoveTimeout([Object? data]) {
		GestureManager.manager()?.eventLongPress(_pointer, _downPoint!);
	}

	void checkmoveMovestart([Object? data]) {
		_timeMachine.delete(_timer);
		GestureManager.manager()?.eventMove(_pointer, ActionModifier.Start, data as Point<double>);
	}

	// void insidetouchdownExit([Object? data]) {
	// }

	void insidetouchdownTouchup([Object? data]) {
		_timeMachine.delete(_timer);
		GestureManager.manager()!.eventTap(_pointer, _downPoint!);
	}

	// void insidetouchdownTouchmove([Object? data]) {
	// }

	void insidetouchdownTimeout([Object? data]) {
		GestureManager.manager()?.eventLongPress(_pointer, _downPoint!);
	}

	void init() {
		helper_.post('init');
	}

	void run(final String eventName, [Object? data]) {
		helper_.post(eventName, data);
	}

	void createHelper() {
		helper_.insert('GestureTrack', 'init', ThreadedCodeExecutor(helper_, 'Idle', [
			// gesturetrackEntry,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('Idle', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			// insidetouchdownEntry,
		]));
		helper_.insert('Idle', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			idleTouchup,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('Moving', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			// movingExit,
			// insidetouchdownEntry,
		]));
		helper_.insert('Moving', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			movingTouchup,
			// movingExit,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('Moving', 'TouchMove', ThreadedCodeExecutor(helper_, 'Moving', [
			// movingTouchmove,
			// movingExit,
			movingEntry,
		]));
		helper_.insert('CheckMove', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			// checkmoveExit,
			// insidetouchdownEntry,
		]));
		helper_.insert('CheckMove', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			checkmoveTouchup,
			// checkmoveExit,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('CheckMove', 'TouchMove', ThreadedCodeExecutor(helper_, 'CheckMove', [
			// checkmoveTouchmove,
			// checkmoveExit,
			checkmoveEntry,
		]));
		helper_.insert('CheckMove', 'Timeout', ThreadedCodeExecutor(helper_, 'Idle', [
			checkmoveTimeout,
			// checkmoveExit,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('CheckMove', 'MoveStart', ThreadedCodeExecutor(helper_, 'Moving', [
			checkmoveMovestart,
			// checkmoveExit,
			movingEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			// insidetouchdownExit,
			// insidetouchdownEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			insidetouchdownTouchup,
			// insidetouchdownExit,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchMove', ThreadedCodeExecutor(helper_, 'CheckMove', [
			// insidetouchdownTouchmove,
			// insidetouchdownExit,
			checkmoveEntry,
		]));
		helper_.insert('InsideTouchDown', 'Timeout', ThreadedCodeExecutor(helper_, 'Idle', [
			insidetouchdownTimeout,
			// insidetouchdownExit,
			// idleExit,
			// gesturetrackInit,
			// idleEntry,
		]));
	}
}
