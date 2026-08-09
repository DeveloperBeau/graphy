// Symmetric xor-mask cipher (xorkey).
import { Bytes } from '../util/Bytes';

export class Xorkey {
  static mask(): number[] {
    return [111, 155, 75];
  }

  static encrypt(text: string, key: number): string {
    const mask = Xorkey.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Xorkey.encrypt(text, key);
  }
}
