// feature: abstract class, mixin, enum
import 'dart:core';

abstract class Greet {
  String hi();
}

mixin Loggable {
  void log(String msg) {
    print(msg);
  }
}

enum State { idle, running, done }
