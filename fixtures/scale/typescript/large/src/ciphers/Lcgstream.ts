// Keystream cipher (lcgstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Lcgstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 177) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (29 * x + 177) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Lcgstream.encrypt(text, key);
  }
}
