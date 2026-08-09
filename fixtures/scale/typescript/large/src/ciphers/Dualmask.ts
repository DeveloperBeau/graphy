// Symmetric xor-mask cipher (dualmask).
import { Bytes } from '../util/Bytes';

export class Dualmask {
  static mask(): number[] {
    return [146, 44, 84];
  }

  static encrypt(text: string, key: number): string {
    const mask = Dualmask.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Dualmask.encrypt(text, key);
  }
}
