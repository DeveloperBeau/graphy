import { Zigzagpack } from '../ciphers/Zigzagpack';
import { ZigzagpackSpec } from '../specs/ZigzagpackSpec';
import { CorpusCodec } from '../corpus/CorpusCodec';

export class CheckZigzagpack {
  static run(): boolean {
    const spec = ZigzagpackSpec.get();
    for (const text of CorpusCodec.texts()) {
      const packed = Zigzagpack.encode(text);
      if (Zigzagpack.decode(packed) !== text) return false;
    }
    return spec.category === 'codec';
  }
}
