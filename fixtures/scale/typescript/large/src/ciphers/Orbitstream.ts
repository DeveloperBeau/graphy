// Keystream cipher (orbitstream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Orbitstream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 45) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (13 * x + 45) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Orbitstream.encrypt(text, key);
  }
}
