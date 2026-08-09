import xorkey from '../ciphers/xorkey.js';
import xorkeySpecMod from '../specs/xorkeySpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkXorkey() {
  const spec = xorkeySpecMod.xorkeySpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = xorkey.xorkeyEncrypt(text, spec.key);
    const opened = xorkey.xorkeyDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkXorkey };
