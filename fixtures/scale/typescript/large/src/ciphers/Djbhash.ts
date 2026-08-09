// Rolling digest (djbhash): init=131071, multiplier=43.
import { Bytes } from '../util/Bytes';

export class Djbhash {
  static digest(text: string): string {
    let h = 131071;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 43) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Djbhash.digest(text), text.length];
  }
}
