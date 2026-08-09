import { Chainhash } from '../ciphers/Chainhash';
import { ChainhashSpec } from '../specs/ChainhashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckChainhash {
  static run(): boolean {
    const spec = ChainhashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Chainhash.digest(text);
      const second = Chainhash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
