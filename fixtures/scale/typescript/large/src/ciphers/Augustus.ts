// Additive byte-shift cipher (augustus).
import { Bytes } from '../util/Bytes';

export class Augustus {
  static encrypt(text: string, key: number): string {
    const shift = (key + 5) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 5) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
