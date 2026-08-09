import 'styles.dart';

class Theme {
  final String name;
  final int textColor;
  final bool emphasize;

  const Theme(this.name, this.textColor, this.emphasize);

  String apply(String text) {
    final colored = textColor == 0 ? text : colorize(text, textColor);
    return emphasize ? bold(colored) : colored;
  }

  factory Theme.named(String name) {
    switch (name) {
      case 'ocean':
        return Theme(name, 36, false);
      case 'alert':
        return Theme(name, 31, true);
      default:
        return const Theme('plain', 0, false);
    }
  }
}
