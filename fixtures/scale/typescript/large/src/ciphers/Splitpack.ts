// Self-inverse codec (splitpack): reverse chunks of 2.
export class Splitpack {
  static encode(text: string): string {
    const k = 2;
    const parts: string[] = [];
    for (let i = 0; i < text.length; i += k) {
      parts.push(text.slice(i, i + k).split('').reverse().join(''));
    }
    return parts.join('');
  }

  static decode(text: string): string {
    return Splitpack.encode(text);
  }
}
