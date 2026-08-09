import { Blockrotate } from '../ciphers/Blockrotate';
import { BlockrotateSpec } from '../specs/BlockrotateSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckBlockrotate {
  static run(): boolean {
    const spec = BlockrotateSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Blockrotate.encrypt(text, spec.key);
      const opened = Blockrotate.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
