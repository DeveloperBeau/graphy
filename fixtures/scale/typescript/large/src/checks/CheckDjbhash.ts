import { Djbhash } from '../ciphers/Djbhash';
import { DjbhashSpec } from '../specs/DjbhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckDjbhash {
  static run(): boolean {
    const spec = DjbhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Djbhash.digest(text);
      const second = Djbhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
