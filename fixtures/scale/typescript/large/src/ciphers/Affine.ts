// Affine byte cipher (affine): a=25.
import { Bytes } from '../util/Bytes';

export class Affine {
  static encrypt(text: string, key: number): string {
    const offset = (91 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (25 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (91 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (41 * (v - offset)) % 256));
  }
}
