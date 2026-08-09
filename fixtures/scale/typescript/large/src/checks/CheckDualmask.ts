import { Dualmask } from '../ciphers/Dualmask';
import { DualmaskSpec } from '../specs/DualmaskSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckDualmask {
  static run(): boolean {
    const spec = DualmaskSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Dualmask.encrypt(text, spec.key);
      const opened = Dualmask.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
