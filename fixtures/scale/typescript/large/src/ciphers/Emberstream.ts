// Keystream cipher (emberstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Emberstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 76) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (17 * x + 76) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Emberstream.encrypt(text, key);
  }
}
