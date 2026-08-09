import turnstile from '../ciphers/turnstile.js';
import turnstileSpecMod from '../specs/turnstileSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkTurnstile() {
  const spec = turnstileSpecMod.turnstileSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = turnstile.turnstileEncrypt(text, spec.key);
    const opened = turnstile.turnstileDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkTurnstile };
