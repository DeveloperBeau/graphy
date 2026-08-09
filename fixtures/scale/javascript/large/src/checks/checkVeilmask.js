import veilmask from '../ciphers/veilmask.js';
import veilmaskSpecMod from '../specs/veilmaskSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkVeilmask() {
  const spec = veilmaskSpecMod.veilmaskSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = veilmask.veilmaskEncrypt(text, spec.key);
    const opened = veilmask.veilmaskDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkVeilmask };
