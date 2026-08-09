import orbitstream from '../ciphers/orbitstream.js';
import orbitstreamSpecMod from '../specs/orbitstreamSpec.js';
import corpusStreamMod from '../corpus/corpusStream.js';

function checkOrbitstream() {
  const spec = orbitstreamSpecMod.orbitstreamSpec();
  for (const text of corpusStreamMod.corpusStream()) {
    const sealed = orbitstream.orbitstreamEncrypt(text, spec.key);
    const opened = orbitstream.orbitstreamDecrypt(sealed, spec.key);
    if (opened !== text) return false;
  }
  return spec.category === 'stream';
}

export default { checkOrbitstream };
