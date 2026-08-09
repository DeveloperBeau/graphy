import { Decimation } from '../ciphers/Decimation';
import { DecimationSpec } from '../specs/DecimationSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckDecimation {
  static run(): boolean {
    const spec = DecimationSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Decimation.encrypt(text, spec.key);
      const opened = Decimation.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
