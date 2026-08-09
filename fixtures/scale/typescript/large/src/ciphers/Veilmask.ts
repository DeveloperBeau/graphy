// Symmetric xor-mask cipher (veilmask).
import { Bytes } from '../util/Bytes';

export class Veilmask {
  static mask(): number[] {
    return [139, 15, 31];
  }

  static encrypt(text: string, key: number): string {
    const mask = Veilmask.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Veilmask.encrypt(text, key);
  }
}
