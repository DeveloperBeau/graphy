export class Align {
  static left(line: string, width: number): string {
    return line.padEnd(width);
  }

  static right(line: string, width: number): string {
    return line.padStart(width);
  }

  static center(line: string, width: number): string {
    const gap = Math.max(0, width - line.length);
    const left = Math.floor(gap / 2);
    return ' '.repeat(left) + line + ' '.repeat(gap - left);
  }
}
