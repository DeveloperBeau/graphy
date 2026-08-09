import mixcrc from '../ciphers/mixcrc.js';
import mixcrcSpecMod from '../specs/mixcrcSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkMixcrc() {
  const spec = mixcrcSpecMod.mixcrcSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = mixcrc.mixcrcDigest(text);
    const second = mixcrc.mixcrcDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkMixcrc };
