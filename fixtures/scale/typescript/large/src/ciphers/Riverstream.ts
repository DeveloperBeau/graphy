// Keystream cipher (riverstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Riverstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 107) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (21 * x + 107) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Riverstream.encrypt(text, key);
  }
}
