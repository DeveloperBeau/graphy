// Self-inverse codec (byteflip): reverse chunks of 4.
export class Byteflip {
  static encode(text: string): string {
    const k = 4;
    const parts: string[] = [];
    for (let i = 0; i < text.length; i += k) {
      parts.push(text.slice(i, i + k).split('').reverse().join(''));
    }
    return parts.join('');
  }

  static decode(text: string): string {
    return Byteflip.encode(text);
  }
}
