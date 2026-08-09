import { Riverstream } from '../ciphers/Riverstream';
import { RiverstreamSpec } from '../specs/RiverstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckRiverstream {
  static run(): boolean {
    const spec = RiverstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Riverstream.encrypt(text, spec.key);
      const opened = Riverstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
