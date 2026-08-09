import weavehash from '../ciphers/weavehash.js';
import weavehashSpecMod from '../specs/weavehashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkWeavehash() {
  const spec = weavehashSpecMod.weavehashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = weavehash.weavehashDigest(text);
    const second = weavehash.weavehashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkWeavehash };
