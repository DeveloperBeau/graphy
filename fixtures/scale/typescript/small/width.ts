export class Width {
  static visible(line: string): number {
    return line.trimEnd().length;
  }

  static max(lines: string[]): number {
    if (lines.length === 0) return 0;
    return Math.max(...lines.map(Width.visible));
  }
}
