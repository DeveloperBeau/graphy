// Additive byte-shift cipher (trithemius).
import { Bytes } from '../util/Bytes';

export class Trithemius {
  static encrypt(text: string, key: number): string {
    const shift = (key + 13) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 13) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
