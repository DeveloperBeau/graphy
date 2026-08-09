import { Sdbmhash } from '../ciphers/Sdbmhash';
import { SdbmhashSpec } from '../specs/SdbmhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckSdbmhash {
  static run(): boolean {
    const spec = SdbmhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Sdbmhash.digest(text);
      const second = Sdbmhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
