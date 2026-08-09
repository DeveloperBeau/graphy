import dualmask from '../ciphers/dualmask.js';
import dualmaskSpecMod from '../specs/dualmaskSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkDualmask() {
  const spec = dualmaskSpecMod.dualmaskSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = dualmask.dualmaskEncrypt(text, spec.key);
    const opened = dualmask.dualmaskDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkDualmask };
