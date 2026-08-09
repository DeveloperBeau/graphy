import ringshift from '../ciphers/ringshift.js';
import ringshiftSpecMod from '../specs/ringshiftSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkRingshift() {
  const spec = ringshiftSpecMod.ringshiftSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = ringshift.ringshiftEncrypt(text, spec.key);
    const opened = ringshift.ringshiftDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkRingshift };
