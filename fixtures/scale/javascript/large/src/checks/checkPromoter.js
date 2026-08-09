import promoter from '../ciphers/promoter.js';
import promoterSpecMod from '../specs/promoterSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkPromoter() {
  const spec = promoterSpecMod.promoterSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = promoter.promoterEncrypt(text, spec.key);
    const opened = promoter.promoterDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkPromoter };
