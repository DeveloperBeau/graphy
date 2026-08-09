import pearsonhash from '../ciphers/pearsonhash.js';
import pearsonhashSpecMod from '../specs/pearsonhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkPearsonhash() {
  const spec = pearsonhashSpecMod.pearsonhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = pearsonhash.pearsonhashDigest(text);
    const second = pearsonhash.pearsonhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkPearsonhash };
