import skewmap from '../ciphers/skewmap.js';
import skewmapSpecMod from '../specs/skewmapSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkSkewmap() {
  const spec = skewmapSpecMod.skewmapSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = skewmap.skewmapEncrypt(text, spec.key);
    const opened = skewmap.skewmapDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkSkewmap };
