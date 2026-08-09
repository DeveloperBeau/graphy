import { Keypad } from '../ciphers/Keypad';
import { KeypadSpec } from '../specs/KeypadSpec';
import { CorpusAdditive } from '../corpus/CorpusAdditive';

export class CheckKeypad {
  static run(): boolean {
    const spec = KeypadSpec.get();
    for (const text of CorpusAdditive.texts()) {
      const sealed = Keypad.encrypt(text, spec.key);
      const opened = Keypad.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'additive';
  }
}
