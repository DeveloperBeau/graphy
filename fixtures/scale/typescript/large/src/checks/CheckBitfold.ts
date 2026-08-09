import { Bitfold } from '../ciphers/Bitfold';
import { BitfoldSpec } from '../specs/BitfoldSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckBitfold {
  static run(): boolean {
    const spec = BitfoldSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Bitfold.encrypt(text, spec.key);
      const opened = Bitfold.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
