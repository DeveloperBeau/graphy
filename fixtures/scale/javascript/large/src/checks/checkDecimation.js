import decimation from '../ciphers/decimation.js';
import decimationSpecMod from '../specs/decimationSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkDecimation() {
  const spec = decimationSpecMod.decimationSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = decimation.decimationEncrypt(text, spec.key);
    const opened = decimation.decimationDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkDecimation };
