import { Paritymix } from '../ciphers/Paritymix';
import { ParitymixSpec } from '../specs/ParitymixSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckParitymix {
  static run(): boolean {
    const spec = ParitymixSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Paritymix.encrypt(text, spec.key);
      const opened = Paritymix.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
