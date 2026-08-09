import paritymix from '../ciphers/paritymix.js';
import paritymixSpecMod from '../specs/paritymixSpec.js';
import corpusMaskMod from '../corpus/corpusMask.js';

function checkParitymix() {
  const spec = paritymixSpecMod.paritymixSpec();
  for (const text of corpusMaskMod.corpusMask()) {
    const sealed = paritymix.paritymixEncrypt(text, spec.key);
    const opened = paritymix.paritymixDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'mask';
}

export default { checkParitymix };
