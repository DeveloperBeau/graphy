import { Staticpad } from '../ciphers/Staticpad';
import { StaticpadSpec } from '../specs/StaticpadSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckStaticpad {
  static run(): boolean {
    const spec = StaticpadSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Staticpad.encrypt(text, spec.key);
      const opened = Staticpad.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
