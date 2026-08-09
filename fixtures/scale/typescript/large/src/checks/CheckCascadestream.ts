import { Cascadestream } from '../ciphers/Cascadestream';
import { CascadestreamSpec } from '../specs/CascadestreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckCascadestream {
  static run(): boolean {
    const spec = CascadestreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Cascadestream.encrypt(text, spec.key);
      const opened = Cascadestream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
