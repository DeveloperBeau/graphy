// Rolling digest (tallyhash): init=97, multiplier=31.
import { Bytes } from '../util/Bytes';

export class Tallyhash {
  static digest(text: string): string {
    let h = 97;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 31) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Tallyhash.digest(text), text.length];
  }
}
