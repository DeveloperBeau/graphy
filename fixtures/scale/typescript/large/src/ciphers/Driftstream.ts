// Keystream cipher (driftstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Driftstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 208) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (33 * x + 208) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Driftstream.encrypt(text, key);
  }
}
