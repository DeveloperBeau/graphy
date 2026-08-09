import { Hexpack } from '../ciphers/Hexpack';
import { HexpackSpec } from '../specs/HexpackSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckHexpack {
  static run(): boolean {
    const spec = HexpackSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Hexpack.encode(text);
      if (Hexpack.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
