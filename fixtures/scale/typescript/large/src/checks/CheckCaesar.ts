import { Caesar } from '../ciphers/Caesar';
import { CaesarSpec } from '../specs/CaesarSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckCaesar {
  static run(): boolean {
    const spec = CaesarSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Caesar.encrypt(text, spec.key);
      const opened = Caesar.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
