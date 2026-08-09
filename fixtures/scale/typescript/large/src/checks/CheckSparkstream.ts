import { Sparkstream } from '../ciphers/Sparkstream';
import { SparkstreamSpec } from '../specs/SparkstreamSpec';
import { CorpusStream } from '../corpus/CorpusStream';

export class CheckSparkstream {
  static run(): boolean {
    const spec = SparkstreamSpec.get();
    for (const text of CorpusStream.texts()) {
      const sealed = Sparkstream.encrypt(text, spec.key);
      const opened = Sparkstream.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'stream';
  }
}
