const alphabetSize = 26;

bool isUpper(String c) => c.codeUnitAt(0) >= 65 && c.codeUnitAt(0) <= 90;

int indexOf(String c) => c.codeUnitAt(0) - 65;

String charAt(int index) => String.fromCharCode(65 + index % alphabetSize);

String cleanAlphabet(String text) {
  final sb = StringBuffer();
  for (final c in text.toUpperCase().split('')) {
    if (isUpper(c)) sb.write(c);
  }
  return sb.toString();
}
