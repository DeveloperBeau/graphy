import { Trithemius } from '../ciphers/Trithemius';
import { TrithemiusSpec } from '../specs/TrithemiusSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckTrithemius {
  static run(): boolean {
    const spec = TrithemiusSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Trithemius.encrypt(text, spec.key);
      const opened = Trithemius.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
