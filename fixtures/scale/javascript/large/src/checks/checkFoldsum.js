import foldsum from '../ciphers/foldsum.js';
import foldsumSpecMod from '../specs/foldsumSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkFoldsum() {
  const spec = foldsumSpecMod.foldsumSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = foldsum.foldsumDigest(text);
    const second = foldsum.foldsumDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkFoldsum };
