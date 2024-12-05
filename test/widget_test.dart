// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:track_tc/gesture/gesture_manager.dart';
import 'package:track_tc/q_support/tracker.dart';

import 'mock_widget.dart';
import 'runner.dart';

void main() {

  GestureManager .initInstance();

  test('widget registration', () {
    expect(0, GestureManager.manager()?.listenersNumber());
    MockWidget widget = MockWidget();
    expect(1,GestureManager.manager()?.listenersNumber());
    widget.unregister();
    expect(0, GestureManager.manager()?.listenersNumber());
  });

  test('widget actions long press', () async {
    MockWidget widget = MockWidget();

  //  Touch down -> register & touch down
    widget.onDown(123450, const Point<double>(10,10));

    Tracker? tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNotNull);

    await Future.delayed(const Duration(seconds: 2));

    tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNull);

  });

  test('widget actions tap', () async {
    MockWidget widget = MockWidget();

    //  Touch down -> register & touch down
    widget.onDown(123450, const Point<double>(10,10));

    Tracker? tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNotNull);

    widget.onUp(123453, const Point<double>(12,12));

    await Future.delayed(const Duration(seconds: 2));

    tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNull);

  });

  test('widget actions move', () async {
    MockWidget widget = MockWidget();

    //  Touch down -> register & touch down
    widget.onDown(123450, const Point<double>(10,10));

    Tracker? tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNotNull);

    widget.onMove(123455, const Point<double>(12,12));
    widget.onMove(123460, const Point<double>(32,32));

    widget.onUp(123490, const Point<double>(60,60));

    await Future.delayed(const Duration(seconds: 2));

    tracker = GestureManager.manager()?.tracker(1);
    expect(tracker, isNull);

  });

  void f1([Object? data]) {
    print('f1 $data');
  }

  void f2([Object? data]) {
    print('f2 $data');
  }

  void f3([Object? data]) {
    print('f3 $data');
  }

  void f4([Object? data]) {
    print('f4 $data');
  }

  void a1([Object? data]) {
    print('a1 $data');
  }

  void a2([Object? data]) {
    print('a2 $data');
  }

  void a3([Object? data]) {
    print('a3 $data');
  }

  void a4([Object? data]) {
    print('a4 $data');
  }

  test('queue', () async {
    final Queue<Function>	_queue	= Queue<Function>();
    _queue.add(f1);
    scheduleMicrotask(() {
      while (_queue.isNotEmpty) {
        Function f = _queue.removeFirst();
        f();
      }
    });

  });


  test('runner', () /*async*/ {
    Runner runner = Runner();
    runner.run([f1,f2,f3],'s1', 11);
    runner.run([a1,a2,f4],'s2', 22);
    runner.run([a3,a4,f1,f2,f3],'s3',33);
  });
}
