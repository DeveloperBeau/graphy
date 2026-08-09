// Symmetric xor-mask cipher (paritymix).
import { Bytes } from '../util/Bytes';

export class Paritymix {
  static mask(): number[] {
    return [125, 213, 181];
  }

  static encrypt(text: string, key: number): string {
    const mask = Paritymix.mask();
    const codes = Bytes.toCodes(text).map((v, i) => v ^ mask[i % 3] ^ (key % 256));
    return Bytes.fromCodes(codes);
  }

  static decrypt(text: string, key: number): string {
    return Paritymix.encrypt(text, key);
  }
}
