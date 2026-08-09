export class Format {
  static toUpper(text: string): string {
    return text.toUpperCase();
  }

  static repeat(ch: string, n: number): string {
    return ch.repeat(n);
  }

  static underline(text: string): string {
    return text + '\n' + Format.repeat('-', text.length);
  }
}
