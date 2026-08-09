import conveyor from '../ciphers/conveyor.js';
import conveyorSpecMod from '../specs/conveyorSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkConveyor() {
  const spec = conveyorSpecMod.conveyorSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = conveyor.conveyorEncrypt(text, spec.key);
    const opened = conveyor.conveyorDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkConveyor };
