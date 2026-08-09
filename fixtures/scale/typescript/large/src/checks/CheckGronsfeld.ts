import { Gronsfeld } from '../ciphers/Gronsfeld';
import { GronsfeldSpec } from '../specs/GronsfeldSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckGronsfeld {
  static run(): boolean {
    const spec = GronsfeldSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Gronsfeld.encrypt(text, spec.key);
      const opened = Gronsfeld.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
