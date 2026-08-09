String trimTrailingZeros(String formatted) {
  if (!formatted.contains('.')) return formatted;
  var trimmed = formatted;
  while (trimmed.endsWith('0')) {
    trimmed = trimmed.substring(0, trimmed.length - 1);
  }
  if (trimmed.endsWith('.')) trimmed = trimmed.substring(0, trimmed.length - 1);
  return trimmed;
}

String grouped(int value) {
  final text = value.abs().toString();
  final sb = StringBuffer();
  for (var i = 0; i < text.length; i++) {
    if (i > 0 && (text.length - i) % 3 == 0) sb.write(',');
    sb.write(text[i]);
  }
  return (value < 0 ? '-' : '') + sb.toString();
}
