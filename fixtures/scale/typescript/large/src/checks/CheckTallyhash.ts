import { Tallyhash } from '../ciphers/Tallyhash';
import { TallyhashSpec } from '../specs/TallyhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckTallyhash {
  static run(): boolean {
    const spec = TallyhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Tallyhash.digest(text);
      const second = Tallyhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
