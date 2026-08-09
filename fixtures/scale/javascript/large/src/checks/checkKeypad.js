import keypad from '../ciphers/keypad.js';
import keypadSpecMod from '../specs/keypadSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkKeypad() {
  const spec = keypadSpecMod.keypadSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = keypad.keypadEncrypt(text, spec.key);
    const opened = keypad.keypadDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkKeypad };
