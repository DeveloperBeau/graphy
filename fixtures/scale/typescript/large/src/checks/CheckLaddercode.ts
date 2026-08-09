import { Laddercode } from '../ciphers/Laddercode';
import { LaddercodeSpec } from '../specs/LaddercodeSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckLaddercode {
  static run(): boolean {
    const spec = LaddercodeSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Laddercode.encode(text);
      if (Laddercode.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
