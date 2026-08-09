import { Conveyor } from '../ciphers/Conveyor';
import { ConveyorSpec } from '../specs/ConveyorSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckConveyor {
  static run(): boolean {
    const spec = ConveyorSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Conveyor.encrypt(text, spec.key);
      const opened = Conveyor.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
