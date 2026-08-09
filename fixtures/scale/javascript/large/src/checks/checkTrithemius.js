import trithemius from '../ciphers/trithemius.js';
import trithemiusSpecMod from '../specs/trithemiusSpec.js';
import corpusAdditiveMod from '../corpus/corpusAdditive.js';

function checkTrithemius() {
  const spec = trithemiusSpecMod.trithemiusSpec();
  for (const text of corpusAdditiveMod.corpusAdditive()) {
    const sealed = trithemius.trithemiusEncrypt(text, spec.key);
    const opened = trithemius.trithemiusDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'additive';
}

export default { checkTrithemius };
