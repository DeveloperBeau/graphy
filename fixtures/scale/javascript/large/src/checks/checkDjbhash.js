import djbhash from '../ciphers/djbhash.js';
import djbhashSpecMod from '../specs/djbhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkDjbhash() {
  const spec = djbhashSpecMod.djbhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = djbhash.djbhashDigest(text);
    const second = djbhash.djbhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkDjbhash };
