import augustus from '../ciphers/augustus.js';
import augustusSpecMod from '../specs/augustusSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkAugustus() {
  const spec = augustusSpecMod.augustusSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = augustus.augustusEncrypt(text, spec.key);
    const opened = augustus.augustusDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkAugustus };
