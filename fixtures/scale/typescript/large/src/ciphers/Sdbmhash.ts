// Rolling digest (sdbmhash): init=166136247, multiplier=777571.
import { Bytes } from '../util/Bytes';

export class Sdbmhash {
  static digest(text: string): string {
    let h = 166136247;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 777571) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Sdbmhash.digest(text), text.length];
  }
}
