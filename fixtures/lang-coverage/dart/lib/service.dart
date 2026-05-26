// feature: class, import (show), import (as), function
import 'dart:io';
import 'helpers.dart' show Helpers;
import 'types.dart' as types;

class Service {
  final String name;

  Service(this.name);

  String run() {
    final helpers = Helpers();
    final greeting = helpers.formatName(name);
    return greeting;
  }

  String describe() {
    return 'Service($name)';
  }
}

void topLevelHelper() {}
