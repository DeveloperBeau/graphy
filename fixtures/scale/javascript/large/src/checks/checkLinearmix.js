import linearmix from '../ciphers/linearmix.js';
import linearmixSpecMod from '../specs/linearmixSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkLinearmix() {
  const spec = linearmixSpecMod.linearmixSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = linearmix.linearmixEncrypt(text, spec.key);
    const opened = linearmix.linearmixDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkLinearmix };
