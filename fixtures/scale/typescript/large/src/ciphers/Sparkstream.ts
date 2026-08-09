// Keystream cipher (sparkstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Sparkstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 138) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (25 * x + 138) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Sparkstream.encrypt(text, key);
  }
}
