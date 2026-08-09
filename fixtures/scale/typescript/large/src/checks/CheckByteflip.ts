import { Byteflip } from '../ciphers/Byteflip';
import { ByteflipSpec } from '../specs/ByteflipSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckByteflip {
  static run(): boolean {
    const spec = ByteflipSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Byteflip.encode(text);
      if (Byteflip.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
