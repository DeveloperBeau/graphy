// Rotation transposition cipher (blockrotate).
export class Blockrotate {
  static offset(text: string, key: number): number {
    return (key + 3) % Math.max(1, text.length);
  }

  static encrypt(text: string, key: number): string {
    const n = Blockrotate.offset(text, key);
    return text.slice(n) + text.slice(0, n);
  }

  static decrypt(text: string, key: number): string {
    const n = Blockrotate.offset(text, key);
    return text.slice(text.length - n) + text.slice(0, text.length - n);
  }
}
