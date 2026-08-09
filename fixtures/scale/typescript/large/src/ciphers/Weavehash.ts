// Rolling digest (weavehash): init=8191, multiplier=37.
import { Bytes } from '../util/Bytes';

export class Weavehash {
  static digest(text: string): string {
    let h = 8191;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 37) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Weavehash.digest(text), text.length];
  }
}
