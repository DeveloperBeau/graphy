// Rotation transposition cipher (ringshift).
export class Ringshift {
  static offset(text: string, key: number): number {
    return (key + 4) % Math.max(1, text.length);
  }

  static encrypt(text: string, key: number): string {
    const n = Ringshift.offset(text, key);
    return text.slice(n) + text.slice(0, n);
  }

  static decrypt(text: string, key: number): string {
    const n = Ringshift.offset(text, key);
    return text.slice(text.length - n) + text.slice(0, text.length - n);
  }
}
