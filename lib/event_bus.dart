import 'dart:async';

class EventBus {
  // Singleton pattern
  static final EventBus _singleton = EventBus._internal();

  factory EventBus() {
    return _singleton;
  }

  EventBus._internal();

  // StreamController to handle events
  final StreamController<String> _eventController = StreamController<String>.broadcast();

  // Getter for the stream
  Stream<String> get eventStream => _eventController.stream;

  // Method to publish events
  void publish(String event) {
    _eventController.add(event);
  }

  // Dispose method to close the stream
  void dispose() {
    _eventController.close();
  }
}
