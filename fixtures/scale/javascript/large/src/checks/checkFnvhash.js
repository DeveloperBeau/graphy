import fnvhash from '../ciphers/fnvhash.js';
import fnvhashSpecMod from '../specs/fnvhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkFnvhash() {
  const spec = fnvhashSpecMod.fnvhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = fnvhash.fnvhashDigest(text);
    const second = fnvhash.fnvhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkFnvhash };
