// Symmetric xor-mask cipher (staticpad).
import { Bytes } from '../util/Bytes';

export class Staticpad {
  static mask(): number[] {
    return [160, 102, 190];
  }

  static encrypt(text: string, key: number): string {
    const mask = Staticpad.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Staticpad.encrypt(text, key);
  }
}
