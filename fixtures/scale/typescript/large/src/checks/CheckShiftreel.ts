import { Shiftreel } from '../ciphers/Shiftreel';
import { ShiftreelSpec } from '../specs/ShiftreelSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckShiftreel {
  static run(): boolean {
    const spec = ShiftreelSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Shiftreel.encrypt(text, spec.key);
      const opened = Shiftreel.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
