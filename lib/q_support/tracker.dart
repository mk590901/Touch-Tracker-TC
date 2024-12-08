
import 'dart:math';
import '../q_interfaces/i_gesture_listener.dart';
import '../track_helper.dart';

class Tracker {
  late TrackHelper     hsmHelper;
  IGestureListener?    gesture;
  final int           _pointer;
  Point<double>?      _currentPoint;



  Tracker(this._pointer) {
    hsmHelper = TrackHelper(_pointer);
    hsmHelper.init(); //  init state machine
  }

  void done(String event, [Object? data]) { //  Data?
    //print ('tracker done [$event]');
    hsmHelper.run(event, data);
  }

  void init(int time, double x, double y) {
    //contextObject.moveInit(time, x, y);
    hsmHelper.moveInit(time, x, y);
  }

  void update(int time, double x, double y) {
    //contextObject.moveDone(time, x, y, this);
    hsmHelper.moveDone(time, x, y, this);
  }

  void stop() {
    //contextObject.moveStop();
    hsmHelper.moveStop();
  }

  void setCurrentPoint(Point<double> point) {
    _currentPoint = point;
  }

  Point<double>? getCurrentPoint() {
    return _currentPoint;
  }

}