import gronsfeld from '../ciphers/gronsfeld.js';
import gronsfeldSpecMod from '../specs/gronsfeldSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkGronsfeld() {
  const spec = gronsfeldSpecMod.gronsfeldSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = gronsfeld.gronsfeldEncrypt(text, spec.key);
    const opened = gronsfeld.gronsfeldDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkGronsfeld };
