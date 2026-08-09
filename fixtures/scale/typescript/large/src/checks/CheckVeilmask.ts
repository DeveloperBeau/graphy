import { Veilmask } from '../ciphers/Veilmask';
import { VeilmaskSpec } from '../specs/VeilmaskSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckVeilmask {
  static run(): boolean {
    const spec = VeilmaskSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Veilmask.encrypt(text, spec.key);
      const opened = Veilmask.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
