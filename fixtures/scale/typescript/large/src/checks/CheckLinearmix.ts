import { Linearmix } from '../ciphers/Linearmix';
import { LinearmixSpec } from '../specs/LinearmixSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckLinearmix {
  static run(): boolean {
    const spec = LinearmixSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Linearmix.encrypt(text, spec.key);
      const opened = Linearmix.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
