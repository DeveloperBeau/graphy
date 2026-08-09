import windmill from '../ciphers/windmill.js';
import windmillSpecMod from '../specs/windmillSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkWindmill() {
  const spec = windmillSpecMod.windmillSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = windmill.windmillEncrypt(text, spec.key);
    const opened = windmill.windmillDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkWindmill };
