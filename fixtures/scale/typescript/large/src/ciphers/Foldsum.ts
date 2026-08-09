// Rolling digest (foldsum): init=40503, multiplier=40503.
import { Bytes } from '../util/Bytes';

export class Foldsum {
  static digest(text: string): string {
    let h = 40503;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 40503) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Foldsum.digest(text), text.length];
  }
}
