import { Weavecode } from '../ciphers/Weavecode';
import { WeavecodeSpec } from '../specs/WeavecodeSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckWeavecode {
  static run(): boolean {
    const spec = WeavecodeSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Weavecode.encode(text);
      if (Weavecode.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
