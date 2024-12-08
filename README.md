# Touch Tracker TC

__Touch Tracker__ is application uses the standard Flutter's 🙌 GestureDetector component to translate _down_, _up_ and _move_ events to __tap__, __longPress__, __move__ (start, continue and final) and __pause__ commands. The application is a clone to the application https://github.com/mk590901/Touch-Tracker with one significant change: the entire __runtime QHsm framework__ is replaced by the __TrackHelper__ class, which contains the __threaded code__ replaces the state machine.

## Goal

To check the fact that __threaded code__ is capable of, firstly, replacing the __QHsm framework__, and secondly, significantly simplifying the application.

## Important points to note

* The __TrackHelper__ class (file track_helper.dart) is generated automatically by the editor's __planner__ and then adapted to the application: data is added to the class, and the transfer functions are filled with operations for interacting with the __GestureManager__. These are similar to the operations that were previously performed in the __TrackContextObject__ class.
* The __Tracker__ class is changed. Calls to the __TrackContextObject__ object functions are replaced by calls to the __TrackHelper__ object functions.
* Empty transfer functions in the __TrackHelper__ class are removed from the nodes of the __QHsmHelper__ class. This minimizes the threaded code.

## Movie

https://github.com/user-attachments/assets/800fda63-58cc-482b-b968-cc34ed6f4177

## Conclusion

The presented application behaves exactly the same as the application https://github.com/mk590901/Touch-Tracker, although the new version is much simpler and more compact, with the same GUI is the same. The difference is 19,085,113 bytes - 19,020,424 bytes = __64,689__ bytes in favor of the new app.

