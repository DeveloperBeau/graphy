import { Orbitstream } from '../ciphers/Orbitstream';
import { OrbitstreamSpec } from '../specs/OrbitstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckOrbitstream {
  static run(): boolean {
    const spec = OrbitstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Orbitstream.encrypt(text, spec.key);
      const opened = Orbitstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
