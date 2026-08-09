import blockrotate from '../ciphers/blockrotate.js';
import blockrotateSpecMod from '../specs/blockrotateSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkBlockrotate() {
  const spec = blockrotateSpecMod.blockrotateSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = blockrotate.blockrotateEncrypt(text, spec.key);
    const opened = blockrotate.blockrotateDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkBlockrotate };
