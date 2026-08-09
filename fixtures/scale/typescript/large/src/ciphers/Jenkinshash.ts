// Rolling digest (jenkinshash): init=5381, multiplier=33.
import { Bytes } from '../util/Bytes';

export class Jenkinshash {
  static digest(text: string): string {
    let h = 5381;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 33) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Jenkinshash.digest(text), text.length];
  }
}
