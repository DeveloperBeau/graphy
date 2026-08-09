// Affine byte cipher (modwheel): a=5.
import { Bytes } from '../util/Bytes';

export class Modwheel {
  static encrypt(text: string, key: number): string {
    const offset = (124 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (5 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (124 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (205 * (v - offset)) % 256));
  }
}
