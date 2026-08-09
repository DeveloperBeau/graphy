import lattice from '../ciphers/lattice.js';
import latticeSpecMod from '../specs/latticeSpec.js';
import corpusRotateMod from '../corpus/corpusRotate.js';

function checkLattice() {
  const spec = latticeSpecMod.latticeSpec();
  for (const text of corpusRotateMod.corpusRotate()) {
    const sealed = lattice.latticeEncrypt(text, spec.key);
    const opened = lattice.latticeDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'rotate';
}

export default { checkLattice };
