import { Affine } from '../ciphers/Affine';
import { AffineSpec } from '../specs/AffineSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckAffine {
  static run(): boolean {
    const spec = AffineSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Affine.encrypt(text, spec.key);
      const opened = Affine.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
