// Rolling digest (chainhash): init=131, multiplier=131.
import { Bytes } from '../util/Bytes';

export class Chainhash {
  static digest(text: string): string {
    let h = 131;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 131) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Chainhash.digest(text), text.length];
  }
}
