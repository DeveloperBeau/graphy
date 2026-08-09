import { Pulsestream } from '../ciphers/Pulsestream';
import { PulsestreamSpec } from '../specs/PulsestreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckPulsestream {
  static run(): boolean {
    const spec = PulsestreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Pulsestream.encrypt(text, spec.key);
      const opened = Pulsestream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
