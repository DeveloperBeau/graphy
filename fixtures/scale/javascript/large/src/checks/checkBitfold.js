import bitfold from '../ciphers/bitfold.js';
import bitfoldSpecMod from '../specs/bitfoldSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkBitfold() {
  const spec = bitfoldSpecMod.bitfoldSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = bitfold.bitfoldEncrypt(text, spec.key);
    const opened = bitfold.bitfoldDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkBitfold };
