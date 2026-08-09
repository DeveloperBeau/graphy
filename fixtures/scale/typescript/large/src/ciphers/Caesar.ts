// Additive byte-shift cipher (caesar).
import { Bytes } from '../util/Bytes';

export class Caesar {
  static encrypt(text: string, key: number): string {
    const shift = (key + 3) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v + shift));
  }

  static decrypt(text: string, key: number): string {
    const shift = (key + 3) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => v - shift));
  }
}
