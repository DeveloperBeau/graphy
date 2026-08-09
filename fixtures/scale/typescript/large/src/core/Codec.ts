export class Codec {
  static toHex(text: string): string {
    return Array.from(text)
      .map((ch) => (ch.charCodeAt(0) % 256).toString(16).padStart(2, '0'))
      .join('');
  }

  static fingerprint(text: string): string {
    let total = 0;
    for (const ch of text) total += ch.charCodeAt(0);
    return (total % 65536).toString(16).padStart(4, '0');
  }
}
