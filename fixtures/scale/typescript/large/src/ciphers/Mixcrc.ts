// Rolling digest (mixcrc): init=654435747, multiplier=427799.
import { Bytes } from '../util/Bytes';

export class Mixcrc {
  static digest(text: string): string {
    let h = 654435747;
    for (const v of Bytes.toCodes(text)) {
      h = (Math.imul(h, 427799) ^ v) >>> 0;
    }
    return h.toString(16).padStart(8, '0');
  }

  static digestPair(text: string): [string, number] {
    return [Mixcrc.digest(text), text.length];
  }
}
