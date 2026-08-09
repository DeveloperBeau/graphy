import caesar from '../ciphers/caesar.js';
import caesarSpecMod from '../specs/caesarSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkCaesar() {
  const spec = caesarSpecMod.caesarSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = caesar.caesarEncrypt(text, spec.key);
    const opened = caesar.caesarDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkCaesar };
