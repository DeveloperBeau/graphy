import { Mixcrc } from '../ciphers/Mixcrc';
import { MixcrcSpec } from '../specs/MixcrcSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckMixcrc {
  static run(): boolean {
    const spec = MixcrcSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Mixcrc.digest(text);
      const second = Mixcrc.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
