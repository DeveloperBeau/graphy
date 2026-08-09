import { Stridecode } from '../ciphers/Stridecode';
import { StridecodeSpec } from '../specs/StridecodeSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckStridecode {
  static run(): boolean {
    const spec = StridecodeSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Stridecode.encode(text);
      if (Stridecode.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
