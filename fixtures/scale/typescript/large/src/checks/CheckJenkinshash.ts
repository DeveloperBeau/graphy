import { Jenkinshash } from '../ciphers/Jenkinshash';
import { JenkinshashSpec } from '../specs/JenkinshashSpec';
import { CorpusHash } from '../corpus/CorpusHash';

export class CheckJenkinshash {
  static run(): boolean {
    const spec = JenkinshashSpec.get();
    for (const text of CorpusHash.texts()) {
      const first = Jenkinshash.digest(text);
      const second = Jenkinshash.digest(text);
      if (first !== second || first.length !== 8) return false;
    }
    return spec.category === 'hash';
  }
}
