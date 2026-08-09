import jenkinshash from '../ciphers/jenkinshash.js';
import jenkinshashSpecMod from '../specs/jenkinshashSpec.js';
import corpusHashMod from '../corpus/corpusHash.js';

function checkJenkinshash() {
  const spec = jenkinshashSpecMod.jenkinshashSpec();
  for (const text of corpusHashMod.corpusHash()) {
    const first = jenkinshash.jenkinshashDigest(text);
    const second = jenkinshash.jenkinshashDigest(text);
    if (first !== second || first.length !== 8) return false;
  }
  return spec.category === 'hash';
}

export default { checkJenkinshash };
