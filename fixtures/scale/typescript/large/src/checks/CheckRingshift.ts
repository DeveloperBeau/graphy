import { Ringshift } from '../ciphers/Ringshift';
import { RingshiftSpec } from '../specs/RingshiftSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckRingshift {
  static run(): boolean {
    const spec = RingshiftSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Ringshift.encrypt(text, spec.key);
      const opened = Ringshift.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
