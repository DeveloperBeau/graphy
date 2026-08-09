import { Weavehash } from '../ciphers/Weavehash';
import { WeavehashSpec } from '../specs/WeavehashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckWeavehash {
  static run(): boolean {
    const spec = WeavehashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Weavehash.digest(text);
      const second = Weavehash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
