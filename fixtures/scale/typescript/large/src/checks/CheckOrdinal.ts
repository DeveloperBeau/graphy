import { Ordinal } from '../ciphers/Ordinal';
import { OrdinalSpec } from '../specs/OrdinalSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckOrdinal {
  static run(): boolean {
    const spec = OrdinalSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Ordinal.encrypt(text, spec.key);
      const opened = Ordinal.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
