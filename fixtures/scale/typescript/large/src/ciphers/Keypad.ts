// Additive byte-shift cipher (keypad).
import { Bytes } from '../util/Bytes';

export class Keypad {
  static encrypt(text: string, key: number): string {
    const shift = (key + 10) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 10) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
