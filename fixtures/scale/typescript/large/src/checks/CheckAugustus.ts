import { Augustus } from '../ciphers/Augustus';
import { AugustusSpec } from '../specs/AugustusSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckAugustus {
  static run(): boolean {
    const spec = AugustusSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Augustus.encrypt(text, spec.key);
      const opened = Augustus.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
