export class Validate {
  static requireNonEmpty(text: string): string {
    if (!text) throw new Error('empty input');
    return text;
  }

  static clampShift(shift: number): number {
    return ((shift % 26) + 26) % 26;
  }
}
