export class Pad {
  static lines(lines: string[], count: number): string[] {
    const blanks = Array.from({ length: count }, () => '');
    return [...blanks, ...lines, ...blanks];
  }

  static width(lines: string[], width: number): string[] {
    return lines.map((line) => line.padEnd(width));
  }
}
