// Additive byte-shift cipher (gronsfeld).
import { Bytes } from '../util/Bytes';

export class Gronsfeld {
  static encrypt(text: string, key: number): string {
    const shift = (key + 8) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 8) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
