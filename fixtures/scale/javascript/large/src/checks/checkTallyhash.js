import tallyhash from '../ciphers/tallyhash.js';
import tallyhashSpecMod from '../specs/tallyhashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkTallyhash() {
  const spec = tallyhashSpecMod.tallyhashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = tallyhash.tallyhashDigest(text);
    const second = tallyhash.tallyhashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkTallyhash };
