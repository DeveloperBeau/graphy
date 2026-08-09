import { Skewmap } from '../ciphers/Skewmap';
import { SkewmapSpec } from '../specs/SkewmapSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckSkewmap {
  static run(): boolean {
    const spec = SkewmapSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Skewmap.encrypt(text, spec.key);
      const opened = Skewmap.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
