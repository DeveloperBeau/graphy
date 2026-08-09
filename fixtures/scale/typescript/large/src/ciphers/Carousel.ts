// Rotation transposition cipher (carousel).
export class Carousel {
  static offset(text: string, key: number): number {
    return (key + 5) % Math.max(1, text.length);
  }

  static encrypt(text: string, key: number): string {
    const n = Carousel.offset(text, key);
    return text.slice(n) + text.slice(0, n);
  }

  static decrypt(text: string, key: number): string {
    const n = Carousel.offset(text, key);
    return text.slice(text.length - n) + text.slice(0, text.length - n);
  }
}
