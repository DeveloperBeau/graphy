import { Nibbleswap } from '../ciphers/Nibbleswap';
import { NibbleswapSpec } from '../specs/NibbleswapSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckNibbleswap {
  static run(): boolean {
    const spec = NibbleswapSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Nibbleswap.encode(text);
      if (Nibbleswap.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
