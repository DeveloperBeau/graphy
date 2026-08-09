import { Stairstep } from '../ciphers/Stairstep';
import { StairstepSpec } from '../specs/StairstepSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckStairstep {
  static run(): boolean {
    const spec = StairstepSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Stairstep.encrypt(text, spec.key);
      const opened = Stairstep.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
