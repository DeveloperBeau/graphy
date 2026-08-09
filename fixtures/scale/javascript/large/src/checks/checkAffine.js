import affine from '../ciphers/affine.js';
import affineSpecMod from '../specs/affineSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkAffine() {
  const spec = affineSpecMod.affineSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = affine.affineEncrypt(text, spec.key);
    const opened = affine.affineDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkAffine };
