import sdbmhash from '../ciphers/sdbmhash.js';
import sdbmhashSpecMod from '../specs/sdbmhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkSdbmhash() {
  const spec = sdbmhashSpecMod.sdbmhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = sdbmhash.sdbmhashDigest(text);
    const second = sdbmhash.sdbmhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkSdbmhash };
