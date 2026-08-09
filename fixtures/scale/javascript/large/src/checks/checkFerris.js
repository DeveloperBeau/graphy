import ferris from '../ciphers/ferris.js';
import ferrisSpecMod from '../specs/ferrisSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkFerris() {
  const spec = ferrisSpecMod.ferrisSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = ferris.ferrisEncrypt(text, spec.key);
    const opened = ferris.ferrisDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkFerris };
