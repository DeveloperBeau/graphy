const epsilon = 1e-12;

bool nearlyZero(double value) => value.abs() < epsilon;

bool nearlyEqual(double a, double b) {
  final scale = a.abs() > b.abs() ? a.abs() : b.abs();
  return (a - b).abs() < epsilon * (scale > 1.0 ? scale : 1.0);
}
