import { Turnstile } from '../ciphers/Turnstile';
import { TurnstileSpec } from '../specs/TurnstileSpec';
import { CorpusRotate } from '../corpus/CorpusRotate';

export class CheckTurnstile {
  static run(): boolean {
    const spec = TurnstileSpec.get();
    for (const text of CorpusRotate.texts()) {
      const sealed = Turnstile.encrypt(text, spec.key);
      const opened = Turnstile.decrypt(sealed, spec.key);
      if (opened !== text) return false;
    }
    return spec.category === 'rotate';
  }
}
