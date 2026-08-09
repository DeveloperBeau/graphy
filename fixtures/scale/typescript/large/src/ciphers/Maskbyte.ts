// Symmetric xor-mask cipher (maskbyte).
import { Bytes } from '../util/Bytes';

export class Maskbyte {
  static mask(): number[] {
    return [118, 184, 128];
  }

  static encrypt(text: string, key: number): string {
    const mask = Maskbyte.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Maskbyte.encrypt(text, key);
  }
}
