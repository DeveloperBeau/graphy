// Symmetric xor-mask cipher (bitfold).
import { Bytes } from '../util/Bytes';

export class Bitfold {
  static mask(): number[] {
    return [132, 242, 234];
  }

  static encrypt(text: string, key: number): string {
    const mask = Bitfold.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Bitfold.encrypt(text, key);
  }
}
