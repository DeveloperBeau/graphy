import stairstep from '../ciphers/stairstep.js';
import stairstepSpecMod from '../specs/stairstepSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkStairstep() {
  const spec = stairstepSpecMod.stairstepSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = stairstep.stairstepEncrypt(text, spec.key);
    const opened = stairstep.stairstepDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkStairstep };
