// Keystream cipher (cascadestream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Cascadestream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 14) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (9 * x + 14) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Cascadestream.encrypt(text, key);
  }
}
