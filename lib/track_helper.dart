//	Class Sw1Helper automatically generated at 2024-12-04 10:04:16
import '../core/q_hsm_helper.dart';
import '../core/threaded_code_executor.dart';

class Sw1Helper {
	final QHsmHelper	helper_ = QHsmHelper('GestureTrack');

	Sw1Helper() {
		createHelper();
	}

	void gesturetrackEntry([Object? data]) {
	}

	void gesturetrackInit([Object? data]) {
	}

	void idleEntry([Object? data]) {
	}

	void idleTouchdown([Object? data]) {
	}

	void insidetouchdownEntry([Object? data]) {
	}

	void idleTouchup([Object? data]) {
	}

	void idleExit([Object? data]) {
	}

	void movingExit([Object? data]) {
	}

	void movingTouchup([Object? data]) {
	}

	void movingTouchmove([Object? data]) {
	}

	void movingEntry([Object? data]) {
	}

	void checkmoveExit([Object? data]) {
	}

	void checkmoveTouchup([Object? data]) {
	}

	void checkmoveTouchmove([Object? data]) {
	}

	void checkmoveEntry([Object? data]) {
	}

	void checkmoveTimeout([Object? data]) {
	}

	void checkmoveMovestart([Object? data]) {
	}

	void insidetouchdownExit([Object? data]) {
	}

	void insidetouchdownTouchup([Object? data]) {
	}

	void insidetouchdownTouchmove([Object? data]) {
	}

	void insidetouchdownTimeout([Object? data]) {
	}

	void init() {
		helper_.run(helper_.getState(), 'init');
	}

	void run(final String eventName) {
		helper_.run(helper_.getState(), eventName);
	}

	void createHelper() {
		helper_.insert('GestureTrack', 'init', ThreadedCodeExecutor(helper_, 'Idle', [
			gesturetrackEntry,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('Idle', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			insidetouchdownEntry,
		]));
		helper_.insert('Idle', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			idleTouchup,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('Moving', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			movingExit,
			insidetouchdownEntry,
		]));
		helper_.insert('Moving', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			movingTouchup,
			movingExit,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('Moving', 'TouchMove', ThreadedCodeExecutor(helper_, 'Moving', [
			movingTouchmove,
			movingExit,
			movingEntry,
		]));
		helper_.insert('CheckMove', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			checkmoveExit,
			insidetouchdownEntry,
		]));
		helper_.insert('CheckMove', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			checkmoveTouchup,
			checkmoveExit,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('CheckMove', 'TouchMove', ThreadedCodeExecutor(helper_, 'CheckMove', [
			checkmoveTouchmove,
			checkmoveExit,
			checkmoveEntry,
		]));
		helper_.insert('CheckMove', 'Timeout', ThreadedCodeExecutor(helper_, 'Idle', [
			checkmoveTimeout,
			checkmoveExit,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('CheckMove', 'MoveStart', ThreadedCodeExecutor(helper_, 'Moving', [
			checkmoveMovestart,
			checkmoveExit,
			movingEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchDown', ThreadedCodeExecutor(helper_, 'InsideTouchDown', [
			idleTouchdown,
			insidetouchdownExit,
			insidetouchdownEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchUp', ThreadedCodeExecutor(helper_, 'Idle', [
			insidetouchdownTouchup,
			insidetouchdownExit,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
		helper_.insert('InsideTouchDown', 'TouchMove', ThreadedCodeExecutor(helper_, 'CheckMove', [
			insidetouchdownTouchmove,
			insidetouchdownExit,
			checkmoveEntry,
		]));
		helper_.insert('InsideTouchDown', 'Timeout', ThreadedCodeExecutor(helper_, 'Idle', [
			insidetouchdownTimeout,
			insidetouchdownExit,
			idleExit,
			gesturetrackInit,
			idleEntry,
		]));
	}
}
