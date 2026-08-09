import { Nibblexor } from '../ciphers/Nibblexor';
import { NibblexorSpec } from '../specs/NibblexorSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckNibblexor {
  static run(): boolean {
    const spec = NibblexorSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Nibblexor.encrypt(text, spec.key);
      const opened = Nibblexor.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
