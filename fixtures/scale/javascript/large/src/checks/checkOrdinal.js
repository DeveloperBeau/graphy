import ordinal from '../ciphers/ordinal.js';
import ordinalSpecMod from '../specs/ordinalSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkOrdinal() {
  const spec = ordinalSpecMod.ordinalSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = ordinal.ordinalEncrypt(text, spec.key);
    const opened = ordinal.ordinalDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkOrdinal };
