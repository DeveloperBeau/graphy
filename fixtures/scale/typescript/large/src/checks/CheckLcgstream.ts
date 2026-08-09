import { Lcgstream } from '../ciphers/Lcgstream';
import { LcgstreamSpec } from '../specs/LcgstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckLcgstream {
  static run(): boolean {
    const spec = LcgstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Lcgstream.encrypt(text, spec.key);
      const opened = Lcgstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
