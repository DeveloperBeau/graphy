import { Promoter } from '../ciphers/Promoter';
import { PromoterSpec } from '../specs/PromoterSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckPromoter {
  static run(): boolean {
    const spec = PromoterSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Promoter.encrypt(text, spec.key);
      const opened = Promoter.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
