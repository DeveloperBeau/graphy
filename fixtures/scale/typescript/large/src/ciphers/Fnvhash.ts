// Rolling digest (fnvhash): init=524287, multiplier=41.
import { Bytes } from '../util/Bytes';

export class Fnvhash {
  static digest(text: string): string {
    let h = 524287;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 41) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Fnvhash.digest(text), text.length];
  }
}
