// Additive byte-shift cipher (stairstep).
import { Bytes } from '../util/Bytes';

export class Stairstep {
  static encrypt(text: string, key: number): string {
    const shift = (key + 23) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 23) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
