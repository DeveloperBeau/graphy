import { Emberstream } from '../ciphers/Emberstream';
import { EmberstreamSpec } from '../specs/EmberstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckEmberstream {
  static run(): boolean {
    const spec = EmberstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Emberstream.encrypt(text, spec.key);
      const opened = Emberstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
