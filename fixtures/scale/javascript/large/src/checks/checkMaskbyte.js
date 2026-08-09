import maskbyte from '../ciphers/maskbyte.js';
import maskbyteSpecMod from '../specs/maskbyteSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkMaskbyte() {
  const spec = maskbyteSpecMod.maskbyteSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = maskbyte.maskbyteEncrypt(text, spec.key);
    const opened = maskbyte.maskbyteDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkMaskbyte };
