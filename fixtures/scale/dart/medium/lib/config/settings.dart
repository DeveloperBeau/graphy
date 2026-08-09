import 'angle_mode.dart';

class Settings {
  int _precision = 6;
  AngleMode _angleMode = AngleMode.radians;

  int get precision => _precision;

  set precision(int value) {
    _precision = value.clamp(0, 15);
  }

  void useDegrees() {
    _angleMode = AngleMode.degrees;
  }

  void useRadians() {
    _angleMode = AngleMode.radians;
  }

  double toRadians(double value) =>
      _angleMode == AngleMode.degrees ? value * 3.141592653589793 / 180 : value;

  double fromRadians(double value) =>
      _angleMode == AngleMode.degrees ? value * 180 / 3.141592653589793 : value;
}
