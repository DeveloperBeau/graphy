String padTo(String line, int width) =>
    line.length >= width ? line : line + (' ' * (width - line.length));

String repeatChar(String c, int count) => c * count;

int visibleLength(String line) =>
    line.replaceAll(RegExp(r'ESC\[[0-9;]*m'), '').length;

String truncate(String line, int width) =>
    line.length <= width ? line : line.substring(0, width);
