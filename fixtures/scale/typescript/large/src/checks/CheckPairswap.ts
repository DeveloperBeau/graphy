import { Pairswap } from '../ciphers/Pairswap';
import { PairswapSpec } from '../specs/PairswapSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckPairswap {
  static run(): boolean {
    const spec = PairswapSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Pairswap.encode(text);
      if (Pairswap.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
