import nibblexor from '../ciphers/nibblexor.js';
import nibblexorSpecMod from '../specs/nibblexorSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkNibblexor() {
  const spec = nibblexorSpecMod.nibblexorSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = nibblexor.nibblexorEncrypt(text, spec.key);
    const opened = nibblexor.nibblexorDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkNibblexor };
