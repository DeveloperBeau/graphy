// Additive byte-shift cipher (shiftreel).
import { Bytes } from '../util/Bytes';

export class Shiftreel {
  static encrypt(text: string, key: number): string {
    const shift = (key + 18) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 18) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
