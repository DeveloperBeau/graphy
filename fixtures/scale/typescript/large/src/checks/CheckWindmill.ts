import { Windmill } from '../ciphers/Windmill';
import { WindmillSpec } from '../specs/WindmillSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckWindmill {
  static run(): boolean {
    const spec = WindmillSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Windmill.encrypt(text, spec.key);
      const opened = Windmill.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
