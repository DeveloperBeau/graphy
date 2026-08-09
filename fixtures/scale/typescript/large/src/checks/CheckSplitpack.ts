import { Splitpack } from '../ciphers/Splitpack';
import { SplitpackSpec } from '../specs/SplitpackSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckSplitpack {
  static run(): boolean {
    const spec = SplitpackSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Splitpack.encode(text);
      if (Splitpack.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
