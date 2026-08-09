export class Bytes {
  static toCodes(text: string): number[] {
    return Array.from(text).map((ch) => ch.charCodeAt(0));
  }

  static fromCodes(codes: number[]): string {
    return codes.map((c) => String.fromCharCode(((c % 256) + 256) % 256)).join('');
  }

  static xorStream(codes: number[], keyCodes: number[]): number[] {
    return codes.map((c, i) => c ^ keyCodes[i % keyCodes.length]);
  }
}
