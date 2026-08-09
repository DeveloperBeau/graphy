import chainhash from '../ciphers/chainhash.js';
import chainhashSpecMod from '../specs/chainhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkChainhash() {
  const spec = chainhashSpecMod.chainhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = chainhash.chainhashDigest(text);
    const second = chainhash.chainhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkChainhash };
