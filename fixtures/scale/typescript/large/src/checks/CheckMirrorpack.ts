import { Mirrorpack } from '../ciphers/Mirrorpack';
import { MirrorpackSpec } from '../specs/MirrorpackSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckMirrorpack {
  static run(): boolean {
    const spec = MirrorpackSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Mirrorpack.encode(text);
      if (Mirrorpack.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
