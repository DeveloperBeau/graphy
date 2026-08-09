import { Modwheel } from '../ciphers/Modwheel';
import { ModwheelSpec } from '../specs/ModwheelSpec';
import { CorpusAffine } from '../corpus/CorpusAffine';

export class CheckModwheel {
  static run(): boolean {
    const spec = ModwheelSpec.get();
    for (const text of CorpusAffine.texts()) {
      const sealed = Modwheel.encrypt(text, spec.key);
      const opened = Modwheel.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'affine';
  }
}
