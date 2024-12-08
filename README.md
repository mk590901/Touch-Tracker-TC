# Touch Tracker TC

__Touch Tracker__ is application uses the standard Flutter's 🙌 GestureDetector component to translate _down_, _up_ and _move_ events to __tap__, __longPress__, __move__ (start, continue and final) and __pause__ commands. The application is a clone to the application https://github.com/mk590901/Touch-Tracker with one significant change: the entire __runtime QHsm framework__ is replaced by the __TrackHelper__ class, which contains the __threaded code__ replaces the state machine.

## Goal

To check the fact that __threaded code__ is capable of, firstly, replacing the __QHsm framework__, and secondly, significantly simplifying the application.
