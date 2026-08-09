import shiftreel from '../ciphers/shiftreel.js';
import shiftreelSpecMod from '../specs/shiftreelSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkShiftreel() {
  const spec = shiftreelSpecMod.shiftreelSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = shiftreel.shiftreelEncrypt(text, spec.key);
    const opened = shiftreel.shiftreelDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkShiftreel };
