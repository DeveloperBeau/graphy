import { Xorkey } from '../ciphers/Xorkey';
import { XorkeySpec } from '../specs/XorkeySpec';
import { CorpusMask } from '../corpus/CorpusMask';

export class CheckXorkey {
  static run(): boolean {
    const spec = XorkeySpec.get();
    for (const text of CorpusMask.texts()) {
      const sealed = Xorkey.encrypt(text, spec.key);
      const opened = Xorkey.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'mask';
  }
}
