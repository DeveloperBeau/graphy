// Additive byte-shift cipher (ordinal).
import { Bytes } from '../util/Bytes';

export class Ordinal {
  static encrypt(text: string, key: number): string {
    const shift = (key + 15) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 15) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
