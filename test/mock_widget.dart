import 'dart:math';
import 'dart:ui';

import 'package:track_tc/gesture/gesture_manager.dart';
import 'package:track_tc/gesture/gesture_observer.dart';
import 'package:track_tc/gesture/gesture_type.dart';
import 'package:track_tc/q_interfaces/i_gesture_listener.dart';
import 'package:track_tc/q_interfaces/i_update.dart';

class MockWidget implements IUpdate {

  final int clientId = 1;

  MockWidget() {
    GestureObserver client = GestureObserver(this);
    GestureManager.manager()?.register(clientId, client);
  }

  void unregister() {
    GestureManager.manager()?.unregister(clientId);
  }

  void onDown(int time, Point<double> point) {
    GestureManager.manager()?.onDown(time, clientId, point);
  }

  void onMove(int time, Point<double>  point) {
    GestureManager.manager()?.onMove(time, clientId, point);
  }

  void onUp(int time, Point<double>  point) {
    GestureManager.manager()?.onUp(time, clientId, point);
  }

  @override
  void update(GestureType type, [Object? object]) {
    // TODO: implement update
  }

  @override
  void updateAndReset(GestureType type, [Object? object]) {
    print('IUpdate.updateAndReset: [$type]:$object');
  }

  @override
  void updateMove(int pointer, ActionModifier actionModifier, Point<double> point) {
    print('IUpdate.updateMove: [$actionModifier] $pointer $point');
  }

  @override
  void updateScroll(ActionModifier actionModifier, Offset offset) {
    // TODO: implement updateScroll
  }

  @override
  void updateZoom(ActionModifier actionModifier, double parameter) {
    // TODO: implement updateZoom
  }

}