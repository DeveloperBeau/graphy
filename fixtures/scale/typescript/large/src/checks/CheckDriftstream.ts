import { Driftstream } from '../ciphers/Driftstream';
import { DriftstreamSpec } from '../specs/DriftstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckDriftstream {
  static run(): boolean {
    const spec = DriftstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Driftstream.encrypt(text, spec.key);
      const opened = Driftstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
