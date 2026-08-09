import { Maskbyte } from '../ciphers/Maskbyte';
import { MaskbyteSpec } from '../specs/MaskbyteSpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckMaskbyte {
  static run(): boolean {
    const spec = MaskbyteSpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Maskbyte.encrypt(text, spec.key);
      const opened = Maskbyte.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
