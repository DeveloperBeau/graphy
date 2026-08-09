// Affine byte cipher (skewmap): a=9.
import { Bytes } from '../util/Bytes';

export class Skewmap {
  static encrypt(text: string, key: number): string {
    const offset = (146 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (9 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (146 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (57 * (v - offset)) % 256));
  }
}
