// Self-inverse codec (mirrorpack): reverse chunks of 3.
export class Mirrorpack {
  static encode(text: string): string {
    const k = 3;
    const parts: string[] = [];
    for (let i = 0; i < text.length; i += k) {
      parts.push(text.slice(i, i + k).split('').reverse().join(''));
    }
    return parts.join('');
  }

  static decode(text: string): string {
    return Mirrorpack.encode(text);
  }
}
