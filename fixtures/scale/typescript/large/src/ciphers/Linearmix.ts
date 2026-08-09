// Affine byte cipher (linearmix): a=7.
import { Bytes } from '../util/Bytes';

export class Linearmix {
  static encrypt(text: string, key: number): string {
    const offset = (135 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (7 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (135 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (183 * (v - offset)) % 256));
  }
}
