import staticpad from '../ciphers/staticpad.js';
import staticpadSpecMod from '../specs/staticpadSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkStaticpad() {
  const spec = staticpadSpecMod.staticpadSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = staticpad.staticpadEncrypt(text, spec.key);
    const opened = staticpad.staticpadDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkStaticpad };
