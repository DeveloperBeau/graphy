// Keystream cipher (pulsestream) driven by a small LCG.
import { Bytes } from '../util/Bytes';

export class Pulsestream {
  static encrypt(text: string, key: number): string {
    let x = (key * 7 + 239) % 256;
    const out = Bytes.toCodes(text).map((v) => {
      x = (5 * x + 239) % 256;
      return v ^ x;
    });
    return Bytes.fromCodes(out);
  }

  static decrypt(text: string, key: number): string {
    return Pulsestream.encrypt(text, key);
  }
}
