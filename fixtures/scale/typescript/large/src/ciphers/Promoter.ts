// Affine byte cipher (promoter): a=3.
import { Bytes } from '../util/Bytes';

export class Promoter {
  static encrypt(text: string, key: number): string {
    const offset = (113 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (3 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (113 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (171 * (v - offset)) % 256));
  }
}
