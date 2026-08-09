// Affine byte cipher (decimation): a=29.
import { Bytes } from '../util/Bytes';

export class Decimation {
  static encrypt(text: string, key: number): string {
    const offset = (102 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (29 * v + offset) % 256));
  }

  static decrypt(text: string, key: number): string {
    const offset = (102 + key) % 256;
    return Bytes.fromCodes(Bytes.toCodes(text).map((v) => (53 * (v - offset)) % 256));
  }
}
