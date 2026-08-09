import { Pearsonhash } from '../ciphers/Pearsonhash';
import { PearsonhashSpec } from '../specs/PearsonhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckPearsonhash {
  static run(): boolean {
    const spec = PearsonhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Pearsonhash.digest(text);
      const second = Pearsonhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
