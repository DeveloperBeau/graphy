// Symmetric xor-mask cipher (nibblexor).
import { Bytes } from '../util/Bytes';

export class Nibblexor {
  static mask(): number[] {
    return [153, 73, 137];
  }

  static encrypt(text: string, key: number): string {
    const mask = Nibblexor.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Nibblexor.encrypt(text, key);
  }
}
