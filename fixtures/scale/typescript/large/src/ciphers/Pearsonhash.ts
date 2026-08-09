// Rolling digest (pearsonhash): init=65599, multiplier=65599.
import { Bytes } from '../util/Bytes';

export class Pearsonhash {
  static digest(text: string): string {
    let h = 65599;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 65599) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Pearsonhash.digest(text), text.length];
  }
}
