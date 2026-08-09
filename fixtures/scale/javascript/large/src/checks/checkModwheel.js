import modwheel from '../ciphers/modwheel.js';
import modwheelSpecMod from '../specs/modwheelSpec.js';
import corpusAffineMod from '../corpus/corpusAffine.js';

function checkModwheel() {
  const spec = modwheelSpecMod.modwheelSpec();
  for (const text of corpusAffineMod.corpusAffine()) {
    const sealed = modwheel.modwheelEncrypt(text, spec.key);
    const opened = modwheel.modwheelDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'affine';
}

export default { checkModwheel };
