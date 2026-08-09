import { Fnvhash } from '../ciphers/Fnvhash';
import { FnvhashSpec } from '../specs/FnvhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckFnvhash {
  static run(): boolean {
    const spec = FnvhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Fnvhash.digest(text);
      const second = Fnvhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
