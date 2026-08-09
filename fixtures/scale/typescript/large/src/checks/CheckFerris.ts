import { Ferris } from '../ciphers/Ferris';
import { FerrisSpec } from '../specs/FerrisSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckFerris {
  static run(): boolean {
    const spec = FerrisSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Ferris.encrypt(text, spec.key);
      const opened = Ferris.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
